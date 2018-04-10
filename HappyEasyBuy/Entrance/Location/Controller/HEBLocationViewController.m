//
//  HEBLocationViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBLocationViewController.h"
#import "HEBLocationView.h"
#import "HEBShippingAddressViewController.h"

static BOOL kEditConsignee = NO;

@interface HEBLocationViewController ()

@property(nonatomic, strong) HEBLocationView *locationView;

@end

@implementation HEBLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithType:QMUINavigationButtonTypeNormal title:@"管理" tintColor:UIColorBlack position:QMUINavigationButtonPositionNone target:self action:@selector(rightBarButtonItemDidClick)];
}

- (void)setUI {
    HEBLocationView *locationView = [[HEBLocationView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    locationView.getConsignee = kEditConsignee;
    locationView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:nil];
    selfClass(locationView);
    [self.baseView addSubview:locationView];
    [locationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo([self harvestAddress].mas_top);
    }];
    __weak __typeof(self)weakSelf = self;
    locationView.cellStyleChange = ^{
        weakSelf.navigationItem.rightBarButtonItem.title = @"管理";
        weakSelf.locationView.editing = NO;
    };
    locationView.consigneeINFO = ^(HEBLocationModel *model) {
        if (weakSelf.getConsigneeINFO) {
            weakSelf.getConsigneeINFO(model);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    [self loadNetworking];
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:UserAddressList params:@{@"vipid":getUser_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        [weakSelf.locationView.mj_footer endRefreshingWithNoMoreData];
        if (mainModel.status) {
            weakSelf.locationView.locationModelArr = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[HEBLocationModel class] json:mainModel.data]];
            [weakSelf.locationView reloadData];
        }
    }];
}

- (void)rightBarButtonItemDidClick {
    self.locationView.editing = !self.locationView.isEditing;
    self.navigationItem.rightBarButtonItem.title = self.locationView.isEditing?@"完成":@"管理";
}

- (QMUIButton *)harvestAddress {
    QMUIButton *sender = [[QMUIButton alloc] init];
    sender.dividingLine = YES;
    [sender setTitle:@"添加收货地址" forState:UIControlStateNormal];
    [self.baseView addSubview:sender];
    [sender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_offset(44);
    }];
    __weak __typeof(self)weakSelf = self;
    [sender addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        HEBShippingAddressViewController *ship = [[HEBShippingAddressViewController alloc] init];
        ship.title = @"新增收货地址";
        ship.locationAddSuccess = ^(HEBLocationModel *model) {
            [weakSelf.locationView.locationModelArr addObject:model];
            [weakSelf.locationView reloadData];
        };
         [weakSelf.navigationController pushViewController:ship animated:YES];
    }];
    return sender;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.locationView.isEditing) {
        [self rightBarButtonItemDidClick];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)setGetConsignee:(BOOL)getConsignee {
    kEditConsignee = getConsignee;
}

@end
