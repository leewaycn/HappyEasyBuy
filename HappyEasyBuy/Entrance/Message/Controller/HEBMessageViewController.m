//
//  HEBMessageViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/8.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBMessageViewController.h"
#import "HEBMessageView.h"

@interface HEBMessageViewController ()

@property(nonatomic, strong) HEBMessageView *messageView;

@property(nonatomic, assign) int page;

@end

@implementation HEBMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消息";
    self.page = 1;
}

- (void)setUI {
    HEBMessageView *messageView = [[HEBMessageView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    selfClass(messageView);
    [self.baseView addSubview:messageView];
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    __weak __typeof(self)weakSelf = self;
    messageView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf loadNetworking];
    }];
    messageView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadNetworking];
    }];
    messageView.mj_header.automaticallyChangeAlpha = YES;
    [self loadNetworking];
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:MessageList params:@{@"index_page":[NSString stringWithFormat:@"%d", self.page], @"index_size":[NSString stringWithFormat:@"%d", PAGE_SIZE_COUNT]} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf.messageView.mj_header endRefreshing];
        [weakSelf.messageView.mj_footer endRefreshing];
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            if (weakSelf.page != 1 && [mainModel.data count] >= PAGE_SIZE_COUNT) {
                weakSelf.page++;
                [weakSelf.messageView.messageModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBMessageModel class] json:mainModel.data]];
                [weakSelf.messageView.mj_footer resetNoMoreData];
            }
            if (weakSelf.page == 1 && [mainModel.data count] >= PAGE_SIZE_COUNT) {
                [weakSelf.messageView.messageModelArrM removeAllObjects];
                weakSelf.page++;
                [weakSelf.messageView.messageModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBMessageModel class] json:mainModel.data]];
                [weakSelf.messageView.mj_footer resetNoMoreData];
            }
            if (weakSelf.page == 1 && [mainModel.data count] < PAGE_SIZE_COUNT) {
                [weakSelf.messageView.messageModelArrM removeAllObjects];
                [weakSelf.messageView.messageModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBMessageModel class] json:mainModel.data]];
                [weakSelf.messageView.mj_footer endRefreshingWithNoMoreData];
            }
            if (weakSelf.page != 1 && [mainModel.data count] < PAGE_SIZE_COUNT) {
                [weakSelf.messageView.messageModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBMessageModel class] json:mainModel.data]];
                [weakSelf.messageView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.messageView reloadData];
        }
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
