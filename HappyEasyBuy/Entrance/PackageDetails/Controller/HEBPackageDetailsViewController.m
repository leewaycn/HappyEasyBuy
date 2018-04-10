//
//  HEBPackageDetailsViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBPackageDetailsViewController.h"
#import "HEBPackageDetailsView.h"
#import "HEBFoodSnatchOrderPaymentViewController.h"

@interface HEBPackageDetailsViewController ()

@property(nonatomic, strong) HEBPackageDetailsView *deatailView;

@end

@implementation HEBPackageDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"套餐详情";
}

- (void)setUI {
    HEBPackageDetailsView *deatailView = [[HEBPackageDetailsView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(deatailView);
    [self.baseView addSubview:deatailView];
    [deatailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self loadNetworking];
}

- (void)loadNetworking {
    __weak __typeof(self)weakSelf = self;
    [self.progressHUD showAnimated:YES];
    [Networking postUrl:FoodPageINFO params:@{@"f_id":self.objid, @"lat":getLat, @"lng":getLon} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        if (mainModel.status) {
            HEBPackageDetailsModel *model = [HEBPackageDetailsModel yy_modelWithJSON:mainModel.data];
            weakSelf.deatailView.header.cycleScrollView.imageURLStringsGroup = model.imgurl;
            weakSelf.deatailView.header.namelab.text = model.f_name;
            weakSelf.deatailView.header.deslab.text = model.f_name_account;
            weakSelf.deatailView.header.pricelab.text = [NSString stringWithFormat:@"¥ %@", model.f_price];
            weakSelf.deatailView.header.infolab.text = [NSString stringWithFormat:@"门店价¥ %@     已售 %@", model.f_oprice, model.f_sold];
            weakSelf.deatailView.shopINFO.shopName.text = model.name;
            weakSelf.deatailView.shopINFO.address.text = model.address;
            weakSelf.deatailView.shopINFO.distance.text = model.distance;
            [weakSelf.deatailView.shopINFO.callPhone addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", model.phone]]];
            }];
            weakSelf.deatailView.shop_id = model.shop_id;
            weakSelf.deatailView.aging = [NSString stringWithFormat:@"%@ 至 %@", model.f_starttime, model.f_endtime];
            weakSelf.deatailView.useTime = [NSString stringWithFormat:@"%@ 至 %@", model.f_starttime1, model.f_endtime1];
            weakSelf.deatailView.useRules = model.f_rule;
            weakSelf.deatailView.articlesArr = [NSArray yy_modelArrayWithClass:[HEBPackageDetailsArticlesModel class] json:model.package];
            [weakSelf.deatailView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
            [weakSelf.deatailView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
            [weakSelf loadCommentariesNetworkingWithShop_id:model.shop_id];
            [weakSelf.deatailView.header.snapUp addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                if (getUser_id) {
                    HEBFoodSnatchOrderPaymentViewController *vc = [[HEBFoodSnatchOrderPaymentViewController alloc] init];
                    vc.shop_id = model.shop_id;
                    vc.title = model.name;
                    vc.objid = model.f_id;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }else {
                    ISAlertNotLoginMessage;
                }
            }];
        }
    }];
}

- (void)loadCommentariesNetworkingWithShop_id:(NSString *)shopid {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:ShopINFO params:@{@"shopid":shopid, @"index_page":@"1"} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            weakSelf.deatailView.appraiseArr = [NSArray yy_modelArrayWithClass:[HEBPackageDetailsAppraiseModel class] json:mainModel.data];
            [weakSelf.deatailView reloadSection:3 withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
    self.navigationController.navigationBar.tintColor = UIColorBlack;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
