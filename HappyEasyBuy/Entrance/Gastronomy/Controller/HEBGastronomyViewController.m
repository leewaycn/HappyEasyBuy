//
//  HEBGastronomyViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBGastronomyViewController.h"
#import "HEBGastronomyView.h"
#import "HEBSearchViewController.h"

@interface HEBGastronomyViewController ()

/** 搜索按钮 */
@property(nonatomic, strong) QMUIButton *searchBtn;

/** 美食主视图 */
@property(nonatomic, strong) HEBGastronomyView *gastronomyView;

/** 临时存储页码 */
@property(nonatomic, assign) int page;

/** 存储商铺请求信息 */
@property(nonatomic, strong) NSMutableDictionary *params;

@end

@implementation HEBGastronomyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    [self loadSearchView];
    [self loadGastronomyView];
}

- (void)loadSearchView {
    QMUIButton *searchBtn = [[QMUIButton alloc] initWithFrame:CGRectMake(50, (getNavigationHeight-28)/2-(IS_58INCH_SCREEN?22:10), SCREEN_WIDTH-90, 28)];
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
        HEBSearchViewController *search = [[HEBSearchViewController alloc] init];
        [weakSelf.navigationController pushViewController:search animated:YES];
    }];
}

- (void)loadGastronomyView {
    __weak __typeof(self)weakSelf = self;
    HEBGastronomyView *gastronomyView = [[HEBGastronomyView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(gastronomyView);
    [self.baseView addSubview:gastronomyView];
    [gastronomyView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_58INCH_SCREEN) {
            make.top.equalTo(self.baseView.mas_top);
        }else if (@available(iOS 11, *)) {
            make.top.equalTo(self.view.mas_top).offset(-getNavigationHeight);
        }else {
            make.top.equalTo(self.view.mas_top);
        }
        make.left.bottom.right.equalTo(self.view);
    }];
    [weakSelf.params setObject:@"2" forKey:@"status"];
    gastronomyView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         weakSelf.page = 1;
        [weakSelf loadNetworking];
    }];
    gastronomyView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf foodStoresNetworking];
    }];
    gastronomyView.mj_header.automaticallyChangeAlpha = YES;
    gastronomyView.mj_footer.automaticallyHidden = YES;
    gastronomyView.mj_footer.automaticallyChangeAlpha = YES;
    [gastronomyView.mj_header beginRefreshing];
    
    gastronomyView.getNetworkingScreeningDidClick = ^(NSString *objid) {
        weakSelf.gastronomyView.localName = nil;
        weakSelf.gastronomyView.loaclModelArr = nil;
        weakSelf.page = 1;
        [weakSelf.params removeAllObjects];
        weakSelf.params = nil;
        [weakSelf.params setObject:objid forKey:@"cate_id"];
        [weakSelf foodStoresNetworking];
    };
    
    gastronomyView.getLoaclScreeningDidClick = ^(NSString *idx) {
        weakSelf.gastronomyView.networkingName = nil;
        weakSelf.page = 1;
        [weakSelf.params removeAllObjects];
        weakSelf.params = nil;
        switch (idx.intValue) {
                case 0:{
                    [weakSelf.params setObject:@"2" forKey:@"status"];
                }
                break;
                case 1:{
                     [weakSelf.params setObject:@"1" forKey:@"status"];
                }
                break;
                case 2:{
                    [weakSelf.params setObject:@"3" forKey:@"status"];
                }break;
            default:
                break;
        }
        [weakSelf foodStoresNetworking];
    };
    
    [self screeningNetworking];
}

- (void)screeningNetworking {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:FoodAllClass params:@{@"cate_id":self.objid, @"city_id":getCity_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        if (mainModel.status) {
            NSMutableArray *arrM = [NSMutableArray array];
            NSArray<HEBClassificationModel *> *modelArr = [NSArray yy_modelArrayWithClass:[HEBClassificationModel class] json:mainModel.data];
            [modelArr enumerateObjectsUsingBlock:^(HEBClassificationModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
                [dictM setObject:obj.name forKey:@"name"];
                [dictM setObject:obj.objid forKey:@"objid"];
                [dictM setObject:@"" forKey:@"select"];
                [arrM addObject:dictM];
            }];
            weakSelf.gastronomyView.screeningModelArr = arrM;
        }
    }];
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    //美食分类
    [self classificationViewNetworking];
    
}

- (void)classificationViewNetworking {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:FoodClassify params:@{@"id":self.objid, @"city_id":getCity_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        //优选商品
        [weakSelf optionViewNetworking];
        if (mainModel.status) {
            weakSelf.gastronomyView.classificationModelArr = [NSArray yy_modelArrayWithClass:[HEBClassificationModel class] json:mainModel.data];
            [weakSelf.gastronomyView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)optionViewNetworking {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:FoodFirst params:@{@"city_id":getCity_id, @"id":self.objid} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        //美食店铺
        [weakSelf foodStoresNetworking];
        if (mainModel.status) {
            weakSelf.gastronomyView.optimizationModelArr = [NSArray yy_modelArrayWithClass:[HEBOptimizationModel class] json:mainModel.data];
            [weakSelf.gastronomyView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)foodStoresNetworking {
    [self.gastronomyView.localScreeningView removeFromSuperview];
    self.gastronomyView.localScreeningView = nil;
    [self.gastronomyView.networkingScreeningView removeFromSuperview];
    self.gastronomyView.networkingScreeningView = nil;
    [self.progressHUD showAnimated:YES];
    [self.params setObject:[NSString stringWithFormat:@"%d", self.page] forKey:@"index_page"];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:Foodslist params:self.params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        [weakSelf.gastronomyView.mj_header endRefreshing];
        [weakSelf.gastronomyView.mj_footer endRefreshing];
        if (mainModel.status) {
            if ([mainModel.data count] == PAGE_SIZE_COUNT && weakSelf.page != 1) {
                weakSelf.page++;
                [weakSelf.gastronomyView.mj_footer resetNoMoreData];
                [weakSelf.gastronomyView.foodStoresModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBFoodStoresModel class] json:mainModel.data]];
            }
            if ([mainModel.data count] == PAGE_SIZE_COUNT && weakSelf.page == 1) {
                [weakSelf.gastronomyView.foodStoresModelArrM removeAllObjects];
                weakSelf.page++;
                [weakSelf.gastronomyView.mj_footer resetNoMoreData];
                [weakSelf.gastronomyView.foodStoresModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBFoodStoresModel class] json:mainModel.data]];
            }
            if ([mainModel.data count] < PAGE_SIZE_COUNT && weakSelf.page == 1) {
                [weakSelf.gastronomyView.foodStoresModelArrM removeAllObjects];
                [weakSelf.gastronomyView.foodStoresModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBFoodStoresModel class] json:mainModel.data]];
                [weakSelf.gastronomyView.mj_footer endRefreshingWithNoMoreData];
            }
            if ([mainModel.data count] < PAGE_SIZE_COUNT && weakSelf.page != 1) {
                [weakSelf.gastronomyView.foodStoresModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBFoodStoresModel class] json:mainModel.data]];
                [weakSelf.gastronomyView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.gastronomyView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
        }else {
            [weakSelf.gastronomyView.mj_footer endRefreshingWithNoMoreData];
            [weakSelf.gastronomyView.foodStoresModelArrM removeAllObjects];
            [weakSelf.gastronomyView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.searchBtn setHidden:NO];
    if (IS_58INCH_SCREEN) {
        self.navigationController.navigationBar.barTintColor = BASECOLOR;
        self.navigationController.navigationBar.tintColor = UIColorWhite;
    }else {
        [self setNavigationBarTransparence];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBtn setHidden:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (!self.navigationController.viewControllers.count) {
        [self.searchBtn removeFromSuperview];
    }
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
        [_params setObject:[NSString stringWithFormat:@"%d", PAGE_SIZE_COUNT] forKey:@"index_size"];
        [_params setObject:getCity_id forKey:@"city_id"];
        [_params setObject:getLon forKey:@"lng"];
        [_params setObject:getLat forKey:@"lat"];
    }
    return _params;
}

@end
