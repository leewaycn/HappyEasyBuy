//
//  HEBHappyMoneyTopupRecordViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/10.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBHappyMoneyTopupRecordViewController.h"
#import "HEBHappyMoneyTopupRecordView.h"

@interface HEBHappyMoneyTopupRecordViewController ()

@property(nonatomic, strong) HEBHappyMoneyTopupRecordView *recordView;

@property(nonatomic, assign) int page;

@end

@implementation HEBHappyMoneyTopupRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"乐享币充值记录";
}

- (void)setUI {
    self.page = 1;
    HEBHappyMoneyTopupRecordView *recordView = [[HEBHappyMoneyTopupRecordView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(recordView);
    [self.baseView addSubview:recordView];
    [recordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    __weak __typeof(self)weakSelf = self;
    recordView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf loadNetworking];
    }];
    recordView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadNetworking];
    }];
    [self loadNetworking];
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:HappyMoneyTopuplist params:@{@"vip_id":getUser_id, @"index_page":[NSString stringWithFormat:@"%d", self.page], @"index_size":[NSString stringWithFormat:@"%d", PAGE_SIZE_COUNT]} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf.recordView.mj_header endRefreshing];
        [weakSelf.recordView.mj_footer endRefreshing];
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            if (weakSelf.page != 1 && [mainModel.data count] >= PAGE_SIZE_COUNT) {
                weakSelf.page++;
                [weakSelf.recordView.recordModelArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBHappyMoneyTopupRecordModel class] json:mainModel.data]];
                [weakSelf.recordView.mj_footer resetNoMoreData];
            }
            if (weakSelf.page == 1 && [mainModel.data count] >= PAGE_SIZE_COUNT) {
                [weakSelf.recordView.recordModelArr removeAllObjects];
                weakSelf.page++;
                [weakSelf.recordView.recordModelArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBHappyMoneyTopupRecordModel class] json:mainModel.data]];
                [weakSelf.recordView.mj_footer resetNoMoreData];
            }
            if (weakSelf.page == 1 && [mainModel.data count] < PAGE_SIZE_COUNT) {
                [weakSelf.recordView.recordModelArr removeAllObjects];
                [weakSelf.recordView.recordModelArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBHappyMoneyTopupRecordModel class] json:mainModel.data]];
                [weakSelf.recordView.mj_footer endRefreshingWithNoMoreData];
            }
            if (weakSelf.page != 1 && [mainModel.data count] < PAGE_SIZE_COUNT) {
                [weakSelf.recordView.recordModelArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBHappyMoneyTopupRecordModel class] json:mainModel.data]];
                [weakSelf.recordView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.recordView reloadData];
        }
        
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
