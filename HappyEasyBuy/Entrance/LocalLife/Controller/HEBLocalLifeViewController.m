//
//  HEBLocalLifeViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBLocalLifeViewController.h"
#import "HEBLocalLifeView.h"
#import "HEBTakeoutSearchViewController.h"

@interface HEBLocalLifeViewController ()

/** 定位btn */
@property(nonatomic, strong) QMUIButton *localizeBtn;

/** 搜索btn */
@property(nonatomic, strong) QMUIButton *searchBtn;

/** 当前定位lab */
@property(nonatomic, strong) QMUILabel *localize;

/** 本地生活顶部视图 */
@property(nonatomic, strong) UIView *localTopView;

/** 本地生活主视图 */
@property(nonatomic, strong) HEBLocalLifeView *localflifeView;

/** 猜你喜欢请求参数 */
@property(nonatomic, copy) NSMutableDictionary *params;

/** 猜你喜欢页码 */
@property(nonatomic, assign) int page;

/** 猜你喜欢请求地址 */
@property(nonatomic, copy) NSString *url;

@end

@implementation HEBLocalLifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.url = @"Home/Shop/sort";
    self.titleView.title = nil;
}

- (void)setUI {
    
    //加载定位按钮
    [self loadlocalizeView];
    
    //加载搜索按钮
    [self loadSearchView];
    
    //加载主视图
    [self loadlocalflifeView];
    
}

- (void)loadlocalizeView {
    QMUIButton *localizeBtn = [[QMUIButton alloc] initWithFrame:CGRectMake(15, (getNavigationHeight-28)/2-(IS_58INCH_SCREEN?28:14), 80, 28)];
    localizeBtn.userInteractionEnabled = NO;
    selfClass(localizeBtn);
    localizeBtn.backgroundColor = UIColorMakeWithRGBA(256, 256, 256, 0.8);
    localizeBtn.layer.cornerRadius = 12;
    localizeBtn.layer.masksToBounds = YES;
    localizeBtn.layer.borderWidth = 1.f;
    localizeBtn.layer.borderColor = UIColorMakeWithRGBA(1, 1, 1, 0.2).CGColor;
    [self.navigationController.navigationBar addSubview:localizeBtn];

    UIImageView *localizeimg = [[UIImageView alloc] initWithImage:UIImageMake(@"定位")];
    [localizeBtn addSubview:localizeimg];
    [localizeimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(localizeBtn.mas_centerY);
        make.left.equalTo(localizeBtn.mas_left).offset(10);
        make.size.mas_offset(localizeimg.image.size);
    }];
    
    QMUILabel *localize = [[QMUILabel alloc] init];
    selfClass(localize);
    localize.font = UIFontMake(14);
    [localizeBtn addSubview:localize];
    [localize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(localizeBtn.mas_centerY);
        make.left.equalTo(localizeimg.mas_right).offset(7);
        make.right.equalTo(localizeBtn.mas_right);
    }];
}

- (void)loadSearchView {
    QMUIButton *searchBtn = [[QMUIButton alloc] initWithFrame:CGRectMake(self.localizeBtn.right+5, self.localizeBtn.top, SCREEN_WIDTH-self.localizeBtn.width-5-22, 28)];
    selfClass(searchBtn);
    searchBtn.backgroundColor = UIColorMakeWithRGBA(252, 249, 244, 0.8);
    searchBtn.layer.cornerRadius = 12;
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.borderWidth = 1.f;
    searchBtn.layer.borderColor = UIColorMakeWithRGBA(210, 194, 194, 0.8).CGColor;
    [self.navigationController.navigationBar addSubview:searchBtn];
    
    UIImageView *searchimg = [[UIImageView alloc] initWithImage:UIImageMake(@"搜索")];
    [searchBtn addSubview:searchimg];
    [searchimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchBtn.mas_centerY);
        make.left.equalTo(searchBtn.mas_left).offset(15);
        make.top.equalTo(searchBtn.mas_top).offset(5);
        make.bottom.equalTo(searchBtn.mas_bottom).offset(-5);
        make.width.mas_offset(18);
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

- (void)loadlocalflifeView {
    [self.localTopView layoutIfNeeded];
    __weak __typeof(self)weakSelf = self;
    HEBLocalLifeView *localflifeView = [[HEBLocalLifeView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(localflifeView);
    self.localflifeView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf loadNetworking];
    }];
    self.localflifeView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf guessYlikeViewNetworking];
    }];
    self.localflifeView.mj_footer.automaticallyHidden = YES;
    self.localflifeView.mj_footer.automaticallyChangeAlpha = YES;
    self.localflifeView.mj_header.automaticallyChangeAlpha = YES;
    localflifeView.getCityName = ^(NSString *cityName) {
        weakSelf.localize.text = [cityName stringByReplacingOccurrencesOfString:@"市" withString:@""];
        [weakSelf.localflifeView.mj_header beginRefreshing];
    };
    [self.baseView addSubview:localflifeView];
    [localflifeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-getTabBarHeight);
    }];
    [self.baseView sendSubviewToBack:localflifeView];
    localflifeView.getguessYlikeDidClick = ^(QMUIButton *sender) {
        weakSelf.localflifeView.sequencingMsg = nil;
        weakSelf.localflifeView.sequencingCellModelArr = nil;
        weakSelf.localflifeView.shopCellModelArr = nil;
        weakSelf.localflifeView.moneyCellModelArr = nil;
        weakSelf.page = 1;
        [weakSelf.params removeAllObjects];
        weakSelf.params = nil;
        switch (sender.tag) {
            case 101:{
                weakSelf.url = @"Home/Shop/maxSale";
                [weakSelf guessYlikeViewNetworking];
            }break;
            case 102:{
                weakSelf.url = @"Home/Shop/minDistance";
                [weakSelf guessYlikeViewNetworking];
            }break;
            default:
                break;
        }
    };
    localflifeView.getScreeningDidClick = ^(NSInteger idx) {
        weakSelf.localflifeView.shopCellModelArr = nil;
        weakSelf.localflifeView.moneyCellModelArr = nil;
        weakSelf.page = 1;
        weakSelf.url = @"Home/Shop/sort";
        [weakSelf.params removeAllObjects];
        weakSelf.params = nil;
        if (idx == 0) {
            [weakSelf.params removeObjectForKey:@"sorts"];
        }else {
            [weakSelf.params setObject:[NSString stringWithFormat:@"%ld", idx] forKey:@"sorts"];
        }
        [weakSelf guessYlikeViewNetworking];
        [weakSelf.localflifeView scrollToTopAnimated:YES];
    };
    localflifeView.getSelectScreeningINFO = ^(NSDictionary *selectINFO) {
        weakSelf.localflifeView.sequencingCellModelArr = nil;
        weakSelf.localflifeView.sequencingMsg = nil;
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
        [weakSelf guessYlikeViewNetworking];
        [weakSelf.localflifeView scrollToTopAnimated:YES];
    };
}

- (void)loadNetworking {
        //导航分类
        [self classificationViewNetworking];
        [self.progressHUD showAnimated:YES];
}

- (void)classificationViewNetworking {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:CateClass params:@{@"city_id":getCity_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        //热卖商品
        [weakSelf hotSellViewNetworking];
        if (errorData) {
            [weakSelf.localflifeView.mj_footer endRefreshing];
            [weakSelf.localflifeView.mj_header endRefreshing];
        }
        if (mainModel.status) {
            weakSelf.localflifeView.classificationModelArr = [NSArray yy_modelArrayWithClass:[HEBClassificationModel class] json:mainModel.data];
            [weakSelf.localflifeView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)hotSellViewNetworking {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:HomeHotGoods params:@{@"city_id":getCity_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        //优选商品
        [weakSelf optionViewNetworking];
        if (mainModel.status) {
            weakSelf.localflifeView.hotSellModelArr = [NSArray yy_modelArrayWithClass:[HEBHotSellModel class] json:mainModel.data];
            [weakSelf.localflifeView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)optionViewNetworking {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:FoodFirst params:@{@"city_id":getCity_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        //猜你喜欢
        [weakSelf guessYlikeViewNetworking];
        if (mainModel.status) {
            weakSelf.localflifeView.optimizationModelArr = [NSArray yy_modelArrayWithClass:[HEBOptimizationModel class] json:mainModel.data];
            [weakSelf.localflifeView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)guessYlikeViewNetworking {
    [self.params setObject:[NSString stringWithFormat:@"%d", self.page] forKey:@"index_page"];
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:self.url params:self.params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf.localflifeView.mj_footer endRefreshing];
        [weakSelf.localflifeView.mj_header endRefreshing];
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            if ([mainModel.data count] == PAGE_SIZE_COUNT && self.page != 1) {
                weakSelf.page++;
                [weakSelf.localflifeView.mj_footer resetNoMoreData];
                [weakSelf.localflifeView.guessYlikeModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBGuessYlikeModel class] json:mainModel.data]];
            }
            if ([mainModel.data count] == PAGE_SIZE_COUNT && self.page == 1) {
                [weakSelf.localflifeView.guessYlikeModelArrM removeAllObjects];
                weakSelf.page++;
                [weakSelf.localflifeView.mj_footer resetNoMoreData];
                [weakSelf.localflifeView.guessYlikeModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBGuessYlikeModel class] json:mainModel.data]];
            }
            if ([mainModel.data count] < PAGE_SIZE_COUNT && self.page == 1) {
                [weakSelf.localflifeView.guessYlikeModelArrM removeAllObjects];
                [weakSelf.localflifeView.guessYlikeModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBGuessYlikeModel class] json:mainModel.data]];
                [weakSelf.localflifeView.mj_footer endRefreshingWithNoMoreData];
            }
            if ([mainModel.data count] < PAGE_SIZE_COUNT && self.page != 1) {
                [weakSelf.localflifeView.guessYlikeModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBGuessYlikeModel class] json:mainModel.data]];
                [weakSelf.localflifeView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.localflifeView reloadSection:3 withRowAnimation:UITableViewRowAnimationNone];
        }else {
            [weakSelf.localflifeView.mj_footer endRefreshingWithNoMoreData];
            [weakSelf.localflifeView.guessYlikeModelArrM removeAllObjects];
            [weakSelf.localflifeView reloadSection:3 withRowAnimation:UITableViewRowAnimationNone];
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
    if (self.localflifeView.sequencingView) {
        [self.localflifeView.sequencingView removeFromSuperview];
        self.localflifeView.sequencingView = nil;
    }
    if (self.localflifeView.screeningView) {
        [self.localflifeView.screeningView removeFromSuperview];
        self.localflifeView.screeningView = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.searchBtn setHidden:NO];
    [self.localizeBtn setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBtn setHidden:YES];
    [self.localizeBtn setHidden:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

@end
