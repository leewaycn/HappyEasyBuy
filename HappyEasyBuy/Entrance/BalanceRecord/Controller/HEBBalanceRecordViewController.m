//
//  HEBBalanceRecordViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/11.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBBalanceRecordViewController.h"
#import "HEBBalanceRecordView.h"
#import "HEBBalanceRecordToolsView.h"

@interface HEBBalanceRecordViewController ()

@property(nonatomic, copy) NSString *type;

@property(nonatomic, assign) int page;

@property(nonatomic, strong) HEBBalanceRecordView *recordView;

@end

@implementation HEBBalanceRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"余额详情";
}

- (void)setUI {
    self.page = 1;
    self.type = @"1";
    HEBBalanceRecordToolsView *toolsView = [[HEBBalanceRecordToolsView alloc] init];
    [self.baseView addSubview:toolsView];
    [toolsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(44);
    }];
    
    HEBBalanceRecordView *recordView = [[HEBBalanceRecordView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(recordView);
    [self.baseView addSubview:recordView];
    [recordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(toolsView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    weakOBJ(self);
    recordView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.page = 1;
        [weak_self loadNetworking];
    }];
    recordView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weak_self loadNetworking];
    }];
    toolsView.senderDidClick = ^(NSInteger tag) {
        weak_self.page = 1;
        weak_self.type = [NSString stringWithFormat:@"%ld", tag+1];
        [weak_self loadNetworking];
    };
    
    [self loadNetworking];
}

- (void)loadNetworking {
    __weak __typeof(self)weakSelf = self;
    [self.progressHUD showAnimated:YES];
    [Networking postUrl:BalanceRecord params:@{@"vipid":getUser_id, @"type":self.type, @"index_page":[NSString stringWithFormat:@"%d", self.page], @"index_size":[NSString stringWithFormat:@"%d", PAGE_SIZE_COUNT]} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        NSLog(@"%@", response);
        [weakSelf.recordView.mj_header endRefreshing];
        [weakSelf.recordView.mj_footer endRefreshing];
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            if (weakSelf.page != 1 && [mainModel.data count] >= PAGE_SIZE_COUNT) {
                weakSelf.page++;
                [weakSelf.recordView.recordModelArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBBalanceRecordModel class] json:mainModel.data]];
                [weakSelf.recordView.mj_footer resetNoMoreData];
            }
            if (weakSelf.page == 1 && [mainModel.data count] >= PAGE_SIZE_COUNT) {
                [weakSelf.recordView.recordModelArr removeAllObjects];
                weakSelf.page++;
                [weakSelf.recordView.recordModelArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBBalanceRecordModel class] json:mainModel.data]];
                [weakSelf.recordView.mj_footer resetNoMoreData];
            }
            if (weakSelf.page == 1 && [mainModel.data count] < PAGE_SIZE_COUNT) {
                [weakSelf.recordView.recordModelArr removeAllObjects];
                [weakSelf.recordView.recordModelArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBBalanceRecordModel class] json:mainModel.data]];
                [weakSelf.recordView.mj_footer endRefreshingWithNoMoreData];
            }
            if (weakSelf.page != 1 && [mainModel.data count] < PAGE_SIZE_COUNT) {
                [weakSelf.recordView.recordModelArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBBalanceRecordModel class] json:mainModel.data]];
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
