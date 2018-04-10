//
//  HEBGastronomyListViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/24.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBGastronomyListViewController.h"
#import "HEBGastronomyListHeaderToolsView.h"
#import "HEBGastronomyListView.h"

@interface HEBGastronomyListViewController ()

/** 页码 */
@property(nonatomic, assign) int page;

/** 记录筛选状态 */
@property(nonatomic, strong) NSString *status;

/** 请求参数 */
@property(nonatomic, strong) NSMutableDictionary *params;

/** 顶部工具视图 */
@property(nonatomic, strong) HEBGastronomyListHeaderToolsView *headerToolsView;

/** 主视图 */
@property(nonatomic, strong) HEBGastronomyListView *gastronomyListView;

@end

@implementation HEBGastronomyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.status = @"1";
}

- (void)setUI {
    
    //加载顶部工具视图
    [self loadHeaderToolsView];
    
    //加载主体视图
    [self loadGastronomyListView];
}

- (void)loadHeaderToolsView {
    HEBGastronomyListHeaderToolsView *headerToolsView = [[HEBGastronomyListHeaderToolsView alloc] init];
    selfClass(headerToolsView);
    [self.baseView addSubview:headerToolsView];
    [headerToolsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(44);
    }];
    __weak __typeof(self)weakSelf = self;
    headerToolsView.getHeaderToolsDidClick = ^(NSInteger idx) {
        switch (idx) {
            case 0:{
                weakSelf.status = @"2";
            }break;
            case 1:{
                weakSelf.status = @"1";
            }break;
            case 2:{
                weakSelf.status = @"3";
            }break;
            default:
                break;
        }
        [weakSelf loadNetworking];
    };
}

- (void)loadGastronomyListView {
    HEBGastronomyListView *gastronomyListView = [[HEBGastronomyListView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(gastronomyListView);
    [self.baseView addSubview:gastronomyListView];
    [gastronomyListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerToolsView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    __weak __typeof(self)weakSelf = self;
    gastronomyListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [weakSelf loadNetworking];
    }];
    gastronomyListView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadNetworking];
    }];
    gastronomyListView.mj_header.automaticallyChangeAlpha = YES;
    gastronomyListView.mj_footer.automaticallyHidden = YES;
    [gastronomyListView.mj_header beginRefreshing];
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    [self.params setObject:self.status forKey:@"status"];
    [self.params setObject:[NSString stringWithFormat:@"%d", self.page] forKey:@"index_page"];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:Foodslist params:self.params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        [weakSelf.gastronomyListView.mj_header endRefreshing];
        [weakSelf.gastronomyListView.mj_footer endRefreshing];
        if (mainModel.status) {
            if ([mainModel.data count] == PAGE_SIZE_COUNT && weakSelf.page != 1) {
                weakSelf.page++;
                [weakSelf.gastronomyListView.mj_footer resetNoMoreData];
                [weakSelf.gastronomyListView.foodStoresModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBFoodStoresModel class] json:mainModel.data]];
            }
            if ([mainModel.data count] == PAGE_SIZE_COUNT && weakSelf.page == 1) {
                [weakSelf.gastronomyListView.foodStoresModelArrM removeAllObjects];
                weakSelf.page++;
                [weakSelf.gastronomyListView.mj_footer resetNoMoreData];
                [weakSelf.gastronomyListView.foodStoresModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBFoodStoresModel class] json:mainModel.data]];
            }
            if ([mainModel.data count] < PAGE_SIZE_COUNT && weakSelf.page == 1) {
                [weakSelf.gastronomyListView.foodStoresModelArrM removeAllObjects];
                [weakSelf.gastronomyListView.foodStoresModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBFoodStoresModel class] json:mainModel.data]];
                [weakSelf.gastronomyListView.mj_footer endRefreshingWithNoMoreData];
            }
            if ([mainModel.data count] < PAGE_SIZE_COUNT && weakSelf.page != 1) {
                [weakSelf.gastronomyListView.foodStoresModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBFoodStoresModel class] json:mainModel.data]];
                [weakSelf.gastronomyListView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.gastronomyListView reloadData];
        }
    }];
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
        [_params setObject:[NSString stringWithFormat:@"%d", PAGE_SIZE_COUNT] forKey:@"index_size"];
        [_params setObject:getCity_id forKey:@"city_id"];
        [_params setObject:getLon forKey:@"lng"];
        [_params setObject:getLat forKey:@"lat"];
        [_params setObject:self.objid forKey:@"cate_id"];
    }
    return _params;
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
