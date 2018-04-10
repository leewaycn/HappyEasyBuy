//
//  HEBCycleScrollView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBCycleScrollView.h"
#import <SDCycleScrollView.h>
#import <CoreLocation/CoreLocation.h>

@interface HEBCycleScrollView ()<CLLocationManagerDelegate>

/** 轮播图 */
@property(nonatomic, strong) SDCycleScrollView *cycleScrollView;

/** 系统定位 */
@property (nonatomic, strong) CLLocationManager *locationManager;

/** 模型数组 */
@property(nonatomic, strong) NSArray<HEBCycleModel *> *cycleModelArr;

/** 临时存储轮播图类型 */
@property(nonatomic, copy) NSString *type;

@end

@implementation HEBCycleScrollView

- (void)loadView {
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:nil placeholderImage:nil];
    _cycleScrollView.showPageControl = YES;
    _cycleScrollView.backgroundColor = UIColorClear;
    _cycleScrollView.currentPageDotColor = [UIColor orangeColor];
    _cycleScrollView.pageDotColor = UIColorWhite;
    [self addSubview:_cycleScrollView];
    __weak __typeof(self)weakSelf = self;
    _cycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.getCycleScrollDidClick) {
            strongSelf.getCycleScrollDidClick(strongSelf.cycleModelArr[currentIndex]);
        }
    };
}

- (void)startLocationCycleScrollViewType:(NSString *)type {
    selfClass(type);
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        //控制定位精度,越高耗电量越
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // 总是授权
        [self.locationManager requestWhenInUseAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *loc = [locations firstObject];
    [self loadCitylon:[NSString stringWithFormat:@"%f", loc.coordinate.longitude] lat:[NSString stringWithFormat:@"%f", loc.coordinate.latitude]];
    if (!IS_DEBUG) {
        [Tools toolsUserDefaultsSaveOBJ:[NSString stringWithFormat:@"%f", loc.coordinate.longitude] forKey:@"lon"];
        [Tools toolsUserDefaultsSaveOBJ:[NSString stringWithFormat:@"%f", loc.coordinate.latitude] forKey:@"lat"];
    }
    [self.locationManager stopUpdatingLocation];
}

- (void)loadCitylon:(NSString *)lon lat:(NSString *)lat {
    __weak __typeof(self)weakSelf = self;
    if (IS_DEBUG) {
        [Tools toolsUserDefaultsSaveOBJ:@"118.236983" forKey:@"lon"];
        [Tools toolsUserDefaultsSaveOBJ:@"35.006312" forKey:@"lat"];
        [Tools toolsUserDefaultsSaveOBJ:@"147" forKey:@"city_id"];
        lon = @"118.236983";
        lat = @"35.006312";
    }
    [Networking postUrl:GetCityID params:@{@"lon":lon, @"lat":lat} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        if (mainModel.status) {
            [Tools toolsUserDefaultsSaveOBJ:response[@"city_id"] forKey:@"city_id"];
            [weakSelf loadCycle:response[@"city_id"] type:nil];
            if (weakSelf.getCityName) {
                weakSelf.getCityName(response[@"city"]);
            }
        }
    }];
}

- (void)loadCycle:(NSString *)cityid type:(NSString *)type {
    [Networking postUrl:BannerList params:@{@"type":type?type:self.type, @"city_id":cityid} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        if (mainModel.status) {
            self.cycleModelArr = [NSArray yy_modelArrayWithClass:[HEBCycleModel class] json:mainModel.data];
            NSMutableArray *imgArrM = [NSMutableArray array];
            [self.cycleModelArr enumerateObjectsUsingBlock:^(HEBCycleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [imgArrM addObject:obj.pic];
            }];
            _cycleScrollView.imageURLStringsGroup = imgArrM;
            _cycleScrollView.backgroundColor = UIColorWhite;
        }
    }];
}

- (NSArray<HEBCycleModel *> *)cycleModelArr {
    if (!_cycleModelArr) {
        _cycleModelArr = [NSArray array];
    }
    return _cycleModelArr;
}

@end
