//
//  HEBAppraiseViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBAppraiseViewController.h"
#import "HEBAppraiseView.h"

@interface HEBAppraiseViewController ()

/** 记录页码 */
@property(nonatomic, assign) int page;

@property(nonatomic, strong) HEBAppraiseView *appraiseView;

@end

@implementation HEBAppraiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的评价";
}

- (void)setUI {
    self.page = 1;
    HEBAppraiseView *appraiseView = [[HEBAppraiseView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    selfClass(appraiseView);
    [self.baseView addSubview:appraiseView];
    [appraiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    __weak __typeof(self)weakSelf = self;
    appraiseView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf loadNetworking];
    }];
    appraiseView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadNetworking];
    }];
    appraiseView.mj_header.automaticallyChangeAlpha = YES;
    appraiseView.mj_footer.automaticallyHidden = YES;
    [self loadNetworking];
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:UserCommentList params:@{@"vipid":getUser_id, @"index_page":[NSString stringWithFormat:@"%d", self.page], @"index_size":[NSString stringWithFormat:@"%d", PAGE_SIZE_COUNT]} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        NSLog(@"%@", response);
        [weakSelf dismissProgressHUD];
        [weakSelf.appraiseView.mj_header endRefreshing];
        [weakSelf.appraiseView.mj_footer endRefreshing];
        if (mainModel.status) {
            if (weakSelf.page != 1 && [mainModel.data count] >= PAGE_SIZE_COUNT) {
                weakSelf.page++;
                [weakSelf.appraiseView.allCommentsArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBPackageDetailsAppraiseModel class] json:mainModel.data]];
                [weakSelf.appraiseView.mj_footer resetNoMoreData];
            }
            if (weakSelf.page == 1 && [mainModel.data count] >= PAGE_SIZE_COUNT) {
                [weakSelf.appraiseView.allCommentsArrM removeAllObjects];
                weakSelf.page++;
                [weakSelf.appraiseView.allCommentsArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBPackageDetailsAppraiseModel class] json:mainModel.data]];
                [weakSelf.appraiseView.mj_footer resetNoMoreData];
            }
            if (weakSelf.page == 1 && [mainModel.data count] < PAGE_SIZE_COUNT) {
                [weakSelf.appraiseView.allCommentsArrM removeAllObjects];
                [weakSelf.appraiseView.allCommentsArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBPackageDetailsAppraiseModel class] json:mainModel.data]];
                [weakSelf.appraiseView.mj_footer endRefreshingWithNoMoreData];
            }
            if (weakSelf.page != 1 && [mainModel.data count] < PAGE_SIZE_COUNT) {
                [weakSelf.appraiseView.allCommentsArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBPackageDetailsAppraiseModel class] json:mainModel.data]];
                [weakSelf.appraiseView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.appraiseView reloadData];
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
