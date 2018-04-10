//
//  HEBShopDetailsViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/25.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBShopDetailsViewController.h"
#import "HEBShopDetailsView.h"
#import "HEBMapViewController.h"
#import "HEBBuyOrderViewController.h"

@interface HEBShopDetailsViewController ()

/** 主体视图 */
@property(nonatomic, strong) HEBShopDetailsView *shopDetailsView;

@end

@implementation HEBShopDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    HEBShopDetailsView *shopDetailsView = [[HEBShopDetailsView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(shopDetailsView);
    [self.baseView addSubview:shopDetailsView];
    [shopDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [Networking postUrl:FoodINFO params:@{@"shop_id":self.shop_id, @"lng":getLon, @"lat":getLat, @"city_id":getCity_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        if (mainModel.status) {
            HEBShopDetailsModel *model = [HEBShopDetailsModel yy_modelWithJSON:mainModel.data];
            weakSelf.shopDetailsView.headerView.cycleScrollView.imageURLStringsGroup = model.imgurl;
            weakSelf.shopDetailsView.headerView.shopName.text = model.name;
            [weakSelf.shopDetailsView.headerView.start displayRating:model.score];
            weakSelf.shopDetailsView.headerView.businessHours.text = [NSString stringWithFormat:@"%@ - %@", model.dotime, model.totime];
            weakSelf.shopDetailsView.headerView.averaging.text = [NSString stringWithFormat:@"人均¥%@", model.avgprice];
            [weakSelf.shopDetailsView.headerView.address setTitle:model.address forState:UIControlStateNormal];
            weakSelf.shopDetailsView.setMealArr = [NSArray yy_modelArrayWithClass:[HEBShopSetMealModel class] json:model.package];
            [weakSelf.shopDetailsView.headerView.address addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                HEBMapViewController *map = [[HEBMapViewController alloc] init];
                map.lat = model.lat;
                map.lon = model.lng;
                map.shopName = model.name;
                map.address = model.address;
                map.phone = model.phone;
                [weakSelf.navigationController pushViewController:map animated:YES];
            }];
            [weakSelf.shopDetailsView.headerView.callPhone addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", model.phone]]];
            }];
            [weakSelf.shopDetailsView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
            [weakSelf loadShopCouponsWithShip_id:model.shop_id];
            [weakSelf.shopDetailsView.headerView.buy addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                HEBBuyOrderViewController *buyOrder = [[HEBBuyOrderViewController alloc] init];
                buyOrder.title = @"买单";
                buyOrder.shopName = model.name;
                buyOrder.shop_id = weakSelf.shop_id;
                buyOrder.type = @"1";
                [weakSelf.navigationController pushViewController:buyOrder animated:YES];
            }];
        }
    }];
}

- (void)loadShopCouponsWithShip_id:(NSString *)shop_id {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:CouponList params:@{@"shop_type":@"1", @"shop_id":shop_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
    [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            weakSelf.shopDetailsView.couponsArr = [NSArray yy_modelArrayWithClass:[HEBGetCouponsModel class] json:mainModel.data];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self setNavigationBarTransparence];
    self.navigationController.navigationBar.tintColor = UIColorWhite;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

@end
