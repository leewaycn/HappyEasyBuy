//
//  HEBDiscountViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBDiscountViewController.h"
#import "HEBDiscountHeaderView.h"
#import "HEBDiscountView.h"

@interface HEBDiscountViewController ()

@property(nonatomic, strong) HEBDiscountView *discountView;
@property(nonatomic, copy) NSString *type;
@end

@implementation HEBDiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的优惠券";
}

- (void)setUI {
    self.type = @"1";
     HEBDiscountHeaderView *headerView = [[HEBDiscountHeaderView alloc] init];
    [self.baseView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(44);
    }];
    __weak __typeof(self)weakSelf = self;
    headerView.discountDidClick = ^(BOOL type) {
        weakSelf.type = [NSString stringWithFormat:@"%d", type+1];
        [weakSelf loadNetworking];
    };
    
    HEBDiscountView *discountView = [[HEBDiscountView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(discountView);
    [self.baseView addSubview:discountView];
    [discountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self loadNetworking];
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:GetMyCoupon params:@{@"uid":getUser_id, @"type":self.type} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            weakSelf.discountView.modelArr = [NSArray yy_modelArrayWithClass:[HEBDiscountModel class] json:mainModel.data];
        }else {
            weakSelf.discountView.modelArr = nil;
        }
        [weakSelf.discountView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
