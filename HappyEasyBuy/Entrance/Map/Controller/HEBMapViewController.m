//
//  HEBMapViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/25.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBMapViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>

@interface HEBMapViewController ()<MAMapViewDelegate>

/** 地图 */
@property(nonatomic, strong) MAMapView *mapView;

/** 定位点 */
@property(nonatomic, strong) MAPointAnnotation *shopPoint;

@end

@implementation HEBMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地图";
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithType:QMUINavigationButtonTypeNormal title:@"导航" tintColor:UIColorBlack position:QMUINavigationButtonPositionNone target:self action:@selector(rightBarButtonItemDidClick)];
     [[AMapServices sharedServices] setApiKey:@"cf1f3d7eefd08f35dbcfd4c8856003da"];
}

- (void)setUI {
   [AMapServices sharedServices].enableHTTPS = NO;
    [self.baseView addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        [annotationView setSelected:YES animated:YES];
        annotationView.image = UIImageMake(@"定位点");
        return annotationView;
    }
    return nil;
}

- (void)rightBarButtonItemDidClick {
    CLLocationCoordinate2D destination = CLLocationCoordinate2DMake(self.lat, self.lon);
    QMUIAlertController *alert = [QMUIAlertController alertControllerWithTitle:nil message:@"请选择地图" preferredStyle:(QMUIAlertControllerStyleActionSheet)];
    [alert addAction:[QMUIAlertAction actionWithTitle:@"用iPhone自带地图导航" style:(QMUIAlertActionStyleDefault) handler:^(QMUIAlertAction *action) {
        MKMapItem *currentLocation =[MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:destination addressDictionary:nil]];
        [MKMapItem openMapsWithItems:@[currentLocation,toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
    }]];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        [alert addAction:[QMUIAlertAction actionWithTitle:@"用高德地图导航" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertAction *action) {
            NSString *urlsting =[[NSString stringWithFormat:@"iosamap://navi?sourceApplication= &backScheme= &lat=%f&lon=%f&dev=0&style=2",destination.latitude,destination.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlsting]];
        }]];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        [alert addAction:[QMUIAlertAction actionWithTitle:@"用百度地图导航" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertAction *action) {
            NSString *urlsting =[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",destination.latitude,destination.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];
        }]];
    }
    [alert addAction:[QMUIAlertAction actionWithTitle:@"取消" style:(QMUIAlertActionStyleCancel) handler:^(QMUIAlertAction *action) {
        
    }]];
    [alert showWithAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.mapView setZoomLevel:16 atPivot:self.view.center animated:NO];
    self.mapView.selectedAnnotations = self.mapView.annotations;
    [self.mapView showAnnotations:@[self.shopPoint] edgePadding:UIEdgeInsetsMake(0, 0, 0, 0) animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
    self.navigationController.navigationBar.tintColor = UIColorBlack;
}

- (MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectZero];
        _mapView.delegate = self;
        _mapView.backgroundColor = UIColorWhite;
        MAPointAnnotation *shopPoint = [[MAPointAnnotation alloc] init];
        selfClass(shopPoint);
        shopPoint.coordinate = CLLocationCoordinate2DMake(self.lat, self.lon);
        shopPoint.title = self.shopName;
        shopPoint.subtitle = self.address;
        _mapView.centerCoordinate = _mapView.userLocation.location.coordinate;
        [_mapView addAnnotation:shopPoint];
    }
    return _mapView;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
