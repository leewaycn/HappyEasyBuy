//
//  HEBVicinityViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBVicinityViewController.h"
#import "HEBVicinityView.h"
#import "HEBTakeoutSearchViewController.h"

@interface HEBVicinityViewController ()

/** 附近顶部视图 */
@property(nonatomic, strong) UIView *vicinityTopView;

/** 搜索btn */
@property(nonatomic, strong) QMUIButton *searchBtn;

/** 附近主视图 */
@property(nonatomic, strong) HEBVicinityView *vicinityView;

/** 猜你喜欢请求参数 */
@property(nonatomic, copy) NSMutableDictionary *params;

/** 猜你喜欢页码 */
@property(nonatomic, assign) int page;

/** 猜你喜欢请求地址 */
@property(nonatomic, copy) NSString *url;

@end

@implementation HEBVicinityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    self.page = 1;
    self.url = @"Home/Shop/sort";
    if (self.vcTitle.length) {
        self.title = self.vcTitle;
    }else {
        self.titleView.title = nil;
        [self loadSearchView];
    }
    [self loadVicinityView];
    [self loadNetworking];
}

- (void)loadSearchView {
    QMUIButton *searchBtn = [[QMUIButton alloc] initWithFrame:CGRectMake(self.c_type==5?50:15, self.c_type==5?((getNavigationHeight-28)/2-(IS_58INCH_SCREEN?22:10)):((getNavigationHeight-28)/2-(IS_58INCH_SCREEN?28:14)), SCREEN_WIDTH-(self.c_type==5?90:30), 28)];
    selfClass(searchBtn);
    searchBtn.layer.cornerRadius = 12;
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.borderWidth = 1.f;
    searchBtn.layer.borderColor = UIColorMakeWithRGBA(210, 194, 194, 0.8).CGColor;
    searchBtn.backgroundColor = UIColorMakeWithRGBA(252, 249, 244, 0.8);
    [self.navigationController.navigationBar addSubview:searchBtn];
    UIImageView *searchimg = [[UIImageView alloc] initWithImage:UIImageMake(@"搜索")];
    [searchBtn addSubview:searchimg];
    [searchimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchBtn.mas_centerY);
        make.left.equalTo(searchBtn.mas_left).offset(15);
        make.top.equalTo(searchBtn.mas_top).offset(5);
        make.bottom.equalTo(searchBtn.mas_bottom).offset(-5);
        make.width.mas_offset(20);
    }];
    
    UIView *margin = [[UIView alloc] init];
    margin.backgroundColor = UIColorGray;
    [searchBtn addSubview:margin];
    [margin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchimg.mas_right).offset(9);
        make.top.bottom.equalTo(searchimg);
        make.width.mas_offset(1);
    }];
    
    QMUILabel *msg = [[QMUILabel alloc] init];
    msg.text = @"请输入商家或商品名称";
    msg.textColor = UIColorGray;
    msg.font = UIFontMake(14);
    [searchBtn addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchBtn.mas_centerY);
        make.left.equalTo(margin.mas_right).offset(8);
        make.right.equalTo(searchBtn.mas_right);
    }];
    
    __weak __typeof(self)weakSelf = self;
    [searchBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf.navigationController pushViewController:[HEBTakeoutSearchViewController new] animated:YES];
    }];
    
}

- (void)loadVicinityView {
    
    NSLog(@"%d", self.tabBarController.tabBar.isHidden);
    
    __weak __typeof(self)weakSelf = self;
    [self.vicinityTopView layoutIfNeeded];
    HEBVicinityView *vicinityView = [[HEBVicinityView alloc] init];
    vicinityView.dividingLine = YES;
    selfClass(vicinityView);
    [self.baseView addSubview:vicinityView];
    [vicinityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.right.left.equalTo(self.view);
        if (self.hidesBottomBarWhenPushed) {
             make.bottom.equalTo(self.view.mas_bottom);
        }else {
          make.bottom.equalTo(self.view.mas_bottom).offset(-getTabBarHeight);
        }
    }];
    self.vicinityView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       weakSelf.page = 1;
        [weakSelf loadNetworking];
    }];
    weakSelf.vicinityView.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadNetworking];
    }];
    weakSelf.vicinityView.tableView.mj_footer.automaticallyHidden = YES;
//    self.vicinityView.tableView.mj_footer.automaticallyChangeAlpha = YES;
    self.vicinityView.tableView.mj_header.automaticallyChangeAlpha = YES;
    vicinityView.getguessYlikeDidClick = ^(QMUIButton *sender) {
        [[weakSelf.vicinityView.toolsView.btnArrM firstObject] setTitle:@"综合排序" forState:UIControlStateNormal];
        weakSelf.vicinityView.sequencingCellModelArr = nil;
        weakSelf.vicinityView.shopCellModelArr = nil;
        weakSelf.vicinityView.moneyCellModelArr = nil;
        weakSelf.page = 1;
        [weakSelf.params removeAllObjects];
        weakSelf.params = nil;
        switch (sender.tag) {
            case 101:{
                weakSelf.url = @"Home/Shop/maxSale";
                [weakSelf loadNetworking];
            }break;
            case 102:{
                weakSelf.url = @"Home/Shop/minDistance";
                [weakSelf loadNetworking];
            }break;
            default:
                break;
        }
    };
    vicinityView.getScreeningDidClick = ^(NSInteger idx) {
        weakSelf.vicinityView.shopCellModelArr = nil;
        weakSelf.vicinityView.moneyCellModelArr = nil;
        weakSelf.page = 1;
        weakSelf.url = @"Home/Shop/sort";
        [weakSelf.params removeAllObjects];
        weakSelf.params = nil;
        if (idx == 0) {
            [weakSelf.params removeObjectForKey:@"sorts"];
        }else {
            [weakSelf.params setObject:[NSString stringWithFormat:@"%ld", idx] forKey:@"sorts"];
        }
        [weakSelf loadNetworking];
    };
    vicinityView.getSelectScreeningINFO = ^(NSDictionary *selectINFO) {
        [[weakSelf.vicinityView.toolsView.btnArrM firstObject] setTitle:@"综合排序" forState:UIControlStateNormal];
        weakSelf.vicinityView.sequencingCellModelArr = nil;
        [weakSelf.params removeAllObjects];
        weakSelf.params = nil;
        if (selectINFO.count) {
            weakSelf.url = @"Home/Shop/choose";
            if ([selectINFO[@"shop"] length]) {
                if ([selectINFO[@"shop"] isEqualToString:@"免费配送"]) {
                    [weakSelf.params setObject:@"0" forKey:@"delivery"];
                }else {
                    [weakSelf.params setObject:@"1" forKey:@"new"];
                }
            }
            if ([selectINFO[@"money"] length]) {
                NSArray *arr = [[selectINFO[@"money"] stringByReplacingOccurrencesOfString:@"¥" withString:@""] componentsSeparatedByString:@"-"];
                [weakSelf.params setObject:arr[0] forKey:@"avg1"];
                [weakSelf.params setObject:arr[1] forKey:@"avg2"];
            }
        }else {
            weakSelf.url = @"Home/Shop/sort";
        }
        [weakSelf loadNetworking];
    };
    
    
}

- (void)loadNetworking {
    [self.params setObject:[NSString stringWithFormat:@"%d", self.page] forKey:@"index_page"];
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:self.url params:self.params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf.vicinityView.tableView.mj_footer endRefreshing];
        [weakSelf.vicinityView.tableView.mj_header endRefreshing];
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            if ([mainModel.data count] == PAGE_SIZE_COUNT && weakSelf.page != 1) {
                weakSelf.page++;
                [weakSelf.vicinityView.tableView.mj_footer resetNoMoreData];
                [weakSelf.vicinityView.cellModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBGuessYlikeModel class] json:mainModel.data]];
            }
            if ([mainModel.data count] == PAGE_SIZE_COUNT && weakSelf.page == 1) {
                [weakSelf.vicinityView.cellModelArrM removeAllObjects];
                weakSelf.page++;
                [weakSelf.vicinityView.tableView.mj_footer resetNoMoreData];
                [weakSelf.vicinityView.cellModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBGuessYlikeModel class] json:mainModel.data]];
            }
            if ([mainModel.data count] < PAGE_SIZE_COUNT && weakSelf.page == 1) {
                [weakSelf.vicinityView.cellModelArrM removeAllObjects];
                [weakSelf.vicinityView.cellModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBGuessYlikeModel class] json:mainModel.data]];
                [weakSelf.vicinityView.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            if ([mainModel.data count] < PAGE_SIZE_COUNT && weakSelf.page != 1) {
                [weakSelf.vicinityView.cellModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBGuessYlikeModel class] json:mainModel.data]];
                [weakSelf.vicinityView.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.vicinityView.tableView reloadData];
        }else {
            [weakSelf.vicinityView.tableView.mj_footer endRefreshingWithNoMoreData];
            [weakSelf.vicinityView.cellModelArrM removeAllObjects];
            [weakSelf.vicinityView.tableView reloadData];
        }
    }];
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
        [_params setObject:getLat forKey:@"lat"];
        [_params setObject:getLon forKey:@"lng"];
        [_params setObject:[NSString stringWithFormat:@"%d", PAGE_SIZE_COUNT] forKey:@"index_size"];
        [_params setObject:getCity_id forKey:@"city_id"];
    }
    return _params;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.vicinityView.sequencingView) {
        [self.vicinityView.sequencingView removeFromSuperview];
        self.vicinityView.sequencingView = nil;
    }
    if (self.vicinityView.screeningView) {
        [self.vicinityView.screeningView removeFromSuperview];
        self.vicinityView.screeningView = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = BASECOLOR;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.searchBtn setHidden:NO];
    if (self.c_type == 5 || self.vcTitle.length) {
        if (IS_58INCH_SCREEN) {
            self.navigationController.navigationBar.barTintColor = BASECOLOR;
            self.navigationController.navigationBar.tintColor = UIColorWhite;
        }else {
            [self setNavigationBarTransparence];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
    [self.searchBtn setHidden:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.c_type==5||self.vcTitle.length?UIStatusBarStyleDefault:UIStatusBarStyleLightContent;
}

@end
