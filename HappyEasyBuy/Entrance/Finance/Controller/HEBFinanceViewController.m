//
//  HEBFinanceViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/24.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBFinanceViewController.h"
#import "HEBFinanceView.h"
#import "HEBFinanceHeaderModel.h"

@interface HEBFinanceViewController ()

@property(nonatomic, strong) HEBFinanceView *financeView;

@property(nonatomic, assign) int page;

@end

@implementation HEBFinanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    self.page = 1;
    HEBFinanceView *financeView = [[HEBFinanceView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    selfClass(financeView);
    [self.baseView addSubview:financeView];
    [financeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    __weak __typeof(self)weakSelf = self;
    financeView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf loadEarningsListNetworking];
    }];
    financeView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadEarningsListNetworking];
    }];
    financeView.mj_header.automaticallyChangeAlpha = YES;
    [self loadNetworking];
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:GetEarnings params:@{@"u_id":getUser_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf loadEarningsListNetworking];
        HEBFinanceHeaderModel *headerModel = [HEBFinanceHeaderModel yy_modelWithJSON:mainModel.data];
        weakSelf.financeView.headerView.earningsYD.text = [NSString stringWithFormat:@"昨日收益%@元", headerModel.daily_yes];
        weakSelf.financeView.headerView.allMoney.text = [NSString stringWithFormat:@"总金额%@元", headerModel.money];
        weakSelf.financeView.headerView.earnings.firstObject.text = headerModel.daily;
        weakSelf.financeView.headerView.earnings.lastObject.text = headerModel.m_money;
    }];
}

- (void)loadEarningsListNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:GetEarningsList params:@{@"index_page":[NSString stringWithFormat:@"%d", self.page], @"index_size":[NSString stringWithFormat:@"%d", PAGE_SIZE_COUNT]} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        [weakSelf.financeView.mj_footer endRefreshing];
        [weakSelf.financeView.mj_header endRefreshing];
        if (mainModel.status) {
            if ([mainModel.data count] == PAGE_SIZE_COUNT && weakSelf.page != 1) {
                weakSelf.page++;
                [weakSelf.financeView.mj_footer resetNoMoreData];
                [weakSelf.financeView.financeModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBFinanceModel class] json:mainModel.data]];
            }
            if ([mainModel.data count] == PAGE_SIZE_COUNT && weakSelf.page == 1) {
                [weakSelf.financeView.financeModelArrM removeAllObjects];
                weakSelf.page++;
                [weakSelf.financeView.mj_footer resetNoMoreData];
                [weakSelf.financeView.financeModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBFinanceModel class] json:mainModel.data]];
            }
            if ([mainModel.data count] < PAGE_SIZE_COUNT && weakSelf.page == 1) {
                [weakSelf.financeView.financeModelArrM removeAllObjects];
                [weakSelf.financeView.financeModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBFinanceModel class] json:mainModel.data]];
                [weakSelf.financeView.mj_footer endRefreshingWithNoMoreData];
            }
            if ([mainModel.data count] < PAGE_SIZE_COUNT && weakSelf.page != 1) {
                [weakSelf.financeView.financeModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBFinanceModel class] json:mainModel.data]];
                [weakSelf.financeView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.financeView reloadData];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = BASECOLOR;
    self.navigationController.navigationBar.tintColor = UIColorWhite;
}

@end
