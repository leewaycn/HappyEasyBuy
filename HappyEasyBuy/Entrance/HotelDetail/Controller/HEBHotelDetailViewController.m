//
//  HEBHotelDetailViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBHotelDetailViewController.h"
#import "HEBHotelDetailView.h"
#import "HEBMapViewController.h"
#import "HEBHotelDetailModel.h"

@interface HEBHotelDetailViewController ()

@property(nonatomic, strong) HEBHotelDetailView *detailView;

@end

@implementation HEBHotelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setUI {
    HEBHotelDetailView *detailView = [[HEBHotelDetailView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    detailView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:nil];
    [detailView.mj_footer endRefreshingWithNoMoreData];
    selfClass(detailView);
    self.detailView.hotelid = self.hotelid;
    [self.baseView addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11, *)) {
            make.top.equalTo(self.view.mas_top).offset(-getNavigationHeight);
        }else {
            make.top.equalTo(self.view.mas_top);
        }
        make.left.right.bottom.equalTo(self.view);
    }];
    [self loadNetworking];
}


- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:HotelDetail params:@{@"lat":getLat, @"lng":getLon, @"h_id":self.hotelid} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf loadHotelRoomListNetworking];
        if (mainModel.status) {
            HEBHotelDetailModel *detailModel = [HEBHotelDetailModel yy_modelWithJSON:mainModel.data];
            weakSelf.detailView.headerView.cycleScrollView.imageURLStringsGroup = detailModel.imgurl;
            weakSelf.detailView.headerView.msg.text = [NSString stringWithFormat:@"  %@", detailModel.h_name];
            weakSelf.detailView.headerView.address.text = detailModel.h_address;
            weakSelf.detailView.headerView.distance.text = detailModel.distance;
            weakSelf.detailView.headerView.backgroundColor = UIColorWhite;
            [weakSelf.detailView.headerView.map addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                HEBMapViewController *map = [[HEBMapViewController alloc] init];
                map.lat = detailModel.lat.doubleValue;
                map.lon = detailModel.lng.doubleValue;
                map.shopName = detailModel.h_name;
                map.address = detailModel.h_address;
                [weakSelf.navigationController pushViewController:map animated:YES];
            }];
            [weakSelf.detailView.headerView.callPhone addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                detailModel.h_tel.callPhone = YES;
            }];
        }
    }];
}

- (void)loadHotelRoomListNetworking {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:HotelRoomList params:@{@"h_id":self.hotelid} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf loadCouponNetworking];
        weakSelf.detailView.roomModelArr = [NSArray yy_modelArrayWithClass:[HEBHotelRoomModel class] json:mainModel.data];
    }];
}

- (void)loadCouponNetworking {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:CouponList params:@{@"shop_id":self.hotelid, @"shop_type":@"4"} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        weakSelf.detailView.couponsModelArr = [NSArray yy_modelArrayWithClass:[HEBGetCouponsModel class] json:mainModel.data];
        [weakSelf.detailView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarTransparence];
}

@end
