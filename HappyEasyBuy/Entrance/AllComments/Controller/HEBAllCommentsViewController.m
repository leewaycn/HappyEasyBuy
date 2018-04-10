//
//  HEBAllCommentsViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBAllCommentsViewController.h"
#import "HEBAllCommentsView.h"

#define PSC 10

@interface HEBAllCommentsViewController ()

/** 记录页码 */
@property(nonatomic, assign) int page;

/** 主体视图 */
@property(nonatomic, strong) HEBAllCommentsView *allCommentsView;

@end

@implementation HEBAllCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部评论";
}

- (void)setUI {
    HEBAllCommentsView *allCommentsView = [[HEBAllCommentsView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    selfClass(allCommentsView);
    [self.baseView addSubview:allCommentsView];
    [allCommentsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    __weak __typeof(self)weakSelf = self;
    allCommentsView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf loadNetworking];
    }];
    allCommentsView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadNetworking];
    }];
    allCommentsView.mj_header.automaticallyChangeAlpha = YES;
    allCommentsView.mj_footer.automaticallyHidden = YES;
    [allCommentsView.mj_header beginRefreshing];
}

- (void)loadNetworking {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:ShopINFO params:@{@"shopid":self.shop_id, @"index_page":[NSString stringWithFormat:@"%d", self.page]} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf.allCommentsView.mj_footer endRefreshing];
        [weakSelf.allCommentsView.mj_header endRefreshing];
        if (mainModel.status) {
            if ([mainModel.data count] == PSC && weakSelf.page != 1) {
                weakSelf.page++;
                [weakSelf.allCommentsView.mj_footer resetNoMoreData];
                [weakSelf.allCommentsView.cellModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBPackageDetailsAppraiseModel class] json:mainModel.data]];
            }
            if ([mainModel.data count] == PSC && weakSelf.page == 1) {
                [weakSelf.allCommentsView.cellModelArrM removeAllObjects];
                weakSelf.page++;
                [weakSelf.allCommentsView.mj_footer resetNoMoreData];
                [weakSelf.allCommentsView.cellModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBPackageDetailsAppraiseModel class] json:mainModel.data]];
            }
            if ([mainModel.data count] < PSC && weakSelf.page == 1) {
                [weakSelf.allCommentsView.cellModelArrM removeAllObjects];
                [weakSelf.allCommentsView.cellModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBPackageDetailsAppraiseModel class] json:mainModel.data]];
                [weakSelf.allCommentsView.mj_footer endRefreshingWithNoMoreData];
            }
            if ([mainModel.data count] < PSC && weakSelf.page != 1) {
                [weakSelf.allCommentsView.cellModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBPackageDetailsAppraiseModel class] json:mainModel.data]];
                [weakSelf.allCommentsView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.allCommentsView reloadData];
        }else {
            [weakSelf.allCommentsView.mj_footer endRefreshingWithNoMoreData];
            [weakSelf.allCommentsView.cellModelArrM removeAllObjects];
            [weakSelf.allCommentsView reloadData];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = UIColorBlack;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
