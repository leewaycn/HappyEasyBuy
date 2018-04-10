//
//  HEBMyCenterViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBMyCenterViewController.h"
#import "HEBMyCenterView.h"
#import "HEBSetViewController.h"
#import "HEBMyCenterCell.h"
#import "HEBLoginViewController.h"
#import "HEBPersonInformationVc.h"
#import "HEBMessageViewController.h"

@interface HEBMyCenterViewController ()

/** 个人中心 */
@property(nonatomic, strong) HEBMyCenterView *myCenterView;

@end

@implementation HEBMyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleView.title = nil;
    self.navigationItem.rightBarButtonItems = @[[QMUINavigationButton barButtonItemWithImage:[UIImageMake(@"消息") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] position:QMUINavigationButtonPositionNone target:self action:@selector(messageDidClick)], [QMUINavigationButton barButtonItemWithImage:[UIImageMake(@"shezhi") imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] position:(QMUINavigationButtonPositionNone) target:self action:@selector(rightBarButtonItemDidClick)]];
}

- (void)setUI {
    HEBMyCenterView *myCenterView = [[HEBMyCenterView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(myCenterView);
    [self.baseView addSubview:myCenterView];
    [myCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-getTabBarHeight);
    }];
    [myCenterView.headerView.header addTarget:self action:@selector(headerDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self loadNetworking];
}

- (void)headerDidClick {
    if (getUser_id && @"header".getUserDefaultsINFO && @"nickName".getUserDefaultsINFO) {
        HEBPersonInformationVc *persion = [[HEBPersonInformationVc alloc] init];
        [self.navigationController pushViewController:persion animated:YES];
        __weak __typeof(self)weakSelf = self;
        persion.UserHeaderChange = ^(UIImage *header) {
            [weakSelf.myCenterView.headerView.img setImage:header];
        };
        persion.UserNickNameChange = ^(NSString *nickName) {
            weakSelf.myCenterView.headerView.nickName.text = nickName;
        };
    }else {
        __weak __typeof(self)weakSelf = self;
        HEBLoginViewController *login = [HEBLoginViewController new];
        login.getUserINFO = ^(NSString *userName, NSString *headerimg) {
            weakSelf.myCenterView.headerView.nickName.text = userName;
            [weakSelf.myCenterView.headerView.img yy_setImageWithURL:[NSURL URLWithString:headerimg] options:YYWebImageOptionProgressive];
            [weakSelf loadNetworking];
        };
        [self.navigationController pushViewController:login animated:YES];
    }
}

- (void)loadNetworking {
    if (getUser_id) {
        weakOBJ(self);
        self.myCenterView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weak_self loadBalanceNetworking];
        }];
        [self loadBalanceNetworking];
    }
}

- (void)loadBalanceNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:UserAccountBalance params:@{@"u_id":getUser_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf loadHappyMoneyNetworking];
        if (mainModel.status) {
            HEBMyCenterCell *cell = (id)[weakSelf.myCenterView cellForRow:0 inSection:0];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元", mainModel.data[@"money"]];
        }
    }];
}

- (void)loadHappyMoneyNetworking {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:UserHappyMoney params:@{@"vip_id":getUser_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf loadIntegralNetworking];
        if (mainModel.status) {
            HEBMyCenterCell *cell = (id)[weakSelf.myCenterView cellForRow:1 inSection:0];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@个", mainModel.data[@"consume_coin"]];
        }
    }];
}

- (void)loadIntegralNetworking {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:Myintegral params:@{@"user_id":getUser_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        [weakSelf.myCenterView.mj_header endRefreshing];
        if (mainModel.status) {
            HEBMyCenterCell *cell = (id)[weakSelf.myCenterView cellForRow:2 inSection:0];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@积分", mainModel.data[@"integral"]];
        }
    }];
}

- (void)rightBarButtonItemDidClick {
    __weak __typeof(self)weakSelf = self;
    HEBSetViewController  *setting = [[HEBSetViewController alloc] init];
    setting.Logout = ^(BOOL success) {
        weakSelf.myCenterView.headerView.nickName.text = @"请登录";
        weakSelf.myCenterView.headerView.img.image = UIImageMake(@"默认头像");
        HEBMyCenterCell *cell = (id)[weakSelf.myCenterView cellForRow:0 inSection:0];
        cell.detailTextLabel.text = nil;
        HEBMyCenterCell *cell2 = (id)[weakSelf.myCenterView cellForRow:1 inSection:0];
        cell2.detailTextLabel.text = nil;
        HEBMyCenterCell *cell3 = (id)[weakSelf.myCenterView cellForRow:2 inSection:0];
        cell3.detailTextLabel.text = nil;
        weakSelf.myCenterView.mj_header = nil;
    };
    [self.navigationController pushViewController:setting animated:YES];
}

- (void)messageDidClick {
    [self.navigationController pushViewController:[[HEBMessageViewController alloc] init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = BASECOLOR;
}

@end
