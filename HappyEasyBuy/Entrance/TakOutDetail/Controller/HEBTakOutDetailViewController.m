//
//  HEBTakOutDetailViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/8.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutDetailViewController.h"
#import "HEBTakOutDetailView.h"
#import "HEBMapViewController.h"
#import "HEBTakOutBuyCarModel.h"

#define PSC 10

@interface HEBTakOutDetailToolsModel : NSObject

/** 商品分类名称 */
@property(nonatomic, copy) NSString *cname;

/** 商品分类 */
@property(nonatomic, assign) int sorts;

@end

@implementation HEBTakOutDetailToolsModel
@end

@interface HEBTakOutDetailViewController ()

@property(nonatomic, strong) HEBTakOutDetailView *takoutDetailView;

/** 分类数组 */
@property(nonatomic, strong) NSArray<HEBTakOutDetailToolsModel *> *toolsArr;

/** 记录购物车商品数量🛒 */
@property(nonatomic, assign) NSInteger shopCount;

/** 记录购物车商品总价 */
@property(nonatomic, assign) CGFloat shopMoney;

/** 记录页码 */
@property(nonatomic, assign) int page;

/** 记录购物车商品 */
@property(nonatomic, strong) NSArray<HEBTakOutBuyCarModel *> *buyCarModelArr;

@end

@implementation HEBTakOutDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    HEBTakOutDetailView *takoutDetailView = [[HEBTakOutDetailView alloc] init];
    selfClass(takoutDetailView);
    takoutDetailView.shop_id = self.shop_id;
    [self.baseView addSubview:takoutDetailView];
    [takoutDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11, *)) {
            make.top.equalTo(self.baseView.mas_top).offset(-getNavigationHeight);
        }else {
            make.top.equalTo(self.view.mas_top);
        }
        make.left.right.bottom.equalTo(self.view);
    }];
    __weak __typeof(self)weakSelf = self;
    takoutDetailView.allCommentsView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf loadShopCommentariesNetworking];
    }];
    takoutDetailView.allCommentsView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadShopCommentariesNetworking];
    }];
    takoutDetailView.allCommentsView.mj_header.automaticallyChangeAlpha = YES;
    takoutDetailView.allCommentsView.mj_footer.automaticallyHidden = YES;
    
    [self loadNetworking];
}

- (void)loadNetworking {
    //商品分类
    [self loadToolsNetworking];
    
}

- (void)loadToolsNetworking {
    __weak __typeof(self)weakSelf = self;
    [self.progressHUD showAnimated:YES];
    [Networking postUrl:TakOutShopCate params:@{@"shop_id":self.shop_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        if (getUser_id) {
            [weakSelf loadBuyCarNetworking];
        }else {
            [weakSelf loadFoodListNetworking];
        }
        weakSelf.toolsArr = [NSArray yy_modelArrayWithClass:[HEBTakOutDetailToolsModel class] json:mainModel.data];
    }];
}

- (void)loadBuyCarNetworking {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:BuyCarList params:@{@"user_id":getUser_id, @"shop_id":self.shop_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf loadFoodListNetworking];
        weakSelf.shopCount = 0;
        if (mainModel.status) {
            weakSelf.buyCarModelArr = [NSArray yy_modelArrayWithClass:[HEBTakOutBuyCarModel class] json:mainModel.data];
            [weakSelf.buyCarModelArr enumerateObjectsUsingBlock:^(HEBTakOutBuyCarModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                weakSelf.shopCount = weakSelf.shopCount+obj.quantity;
                weakSelf.shopMoney = weakSelf.shopMoney+obj.quantity*obj.price.floatValue;
            }];
            weakSelf.takoutDetailView.buyCarView.num.hidden = !weakSelf.shopCount;
            weakSelf.takoutDetailView.buyCarView.buyCar.userInteractionEnabled = weakSelf.shopCount;
            weakSelf.takoutDetailView.buyCarView.money.text = [NSString stringWithFormat:@"总价¥%.2f", weakSelf.shopMoney];
            if (weakSelf.shopCount) {
                weakSelf.takoutDetailView.buyCarView.num.text = [NSString stringWithFormat:@"%ld", weakSelf.shopCount];
                weakSelf.takoutDetailView.buyCarView.buyCarBGView.backgroundColor = UIColorBlack;
                [weakSelf.takoutDetailView.buyCarView.buyCar setBackgroundImage:UIImageMake(@"外卖_购物车可用") forState:UIControlStateNormal];
            }else {
                [weakSelf.takoutDetailView.buyCarView hidden];
                [weakSelf.takoutDetailView.buyCarView.buyCar setBackgroundImage:UIImageMake(@"外卖_购物车") forState:UIControlStateNormal];
                weakSelf.takoutDetailView.buyCarView.buyCarBGView.backgroundColor = UIColorHex(#545454);
            }
            [weakSelf.takoutDetailView.buyCarView.pay addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                HEBTakOutOrderDetailViewController *pay = [[HEBTakOutOrderDetailViewController alloc] init];
                pay.shop_id = weakSelf.shop_id;
                pay.money = [NSString stringWithFormat:@"%@", [weakSelf.takoutDetailView.buyCarView.money.text stringByReplacingOccurrencesOfString:@"总价¥" withString:@""]];
                [weakSelf.navigationController pushViewController:pay animated:YES];
            }];
        }
    }];
}

- (void)loadFoodListNetworking {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:TakOutGoodList params:@{@"shop_id":self.shop_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        //店铺评论
        [self loadShopCommentariesNetworking];
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            HEBTakOutDetailModel *shopModel = [HEBTakOutDetailModel yy_modelWithJSON:mainModel.data];
            NSMutableArray *arr = [NSMutableArray array];
            [shopModel.activity enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj[@"huodong"] length]) {
                    [arr addObject:obj[@"huodong"]];
                }
            }];
            if (arr.count) {
                weakSelf.takoutDetailView.shopINFOView.activeMsg.text = [NSString stringWithFormat:@"%ld个活动 >", arr.count];
            }
            weakSelf.takoutDetailView.shopINFOView.shopName.text = shopModel.shop.name;
            weakSelf.takoutDetailView.shopINFOView.cycleScroller.titlesGroup = arr;
            [weakSelf.takoutDetailView.shopINFOView.icon yy_setImageWithURL:[NSURL URLWithString:shopModel.shop.logo] options:YYWebImageOptionProgressive];
            NSArray<HEBTakOutShopModel *> *filterTypeArr = [NSArray yy_modelArrayWithClass:[HEBTakOutShopModel class] json:shopModel.goodslist];
            
            NSMutableArray <NSString *>*filterTypeStrArr = [NSMutableArray array];
            [weakSelf.toolsArr enumerateObjectsUsingBlock:^(HEBTakOutDetailToolsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [filterTypeStrArr addObject:obj.cname];
            }];
            weakSelf.takoutDetailView.filterTypeView.cellModelArr = filterTypeStrArr;
            [weakSelf.takoutDetailView.filterTypeView reloadData];
            [weakSelf.takoutDetailView.filterTypeView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            NSMutableArray<NSMutableArray <HEBTakOutShopModel *> *> *foodListArrM = [NSMutableArray array];
            
            for (int i = 0; i < weakSelf.toolsArr.count; i ++) {
                HEBTakOutDetailToolsModel *model = weakSelf.toolsArr[i];
                NSMutableArray *arr = [NSMutableArray array];
                [filterTypeArr enumerateObjectsUsingBlock:^(HEBTakOutShopModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (model.sorts == obj.sorts) {
                        [arr addObject:obj];
                    }
                    [obj.sku enumerateObjectsUsingBlock:^(HEBTakOutSKUModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        HEBTakOutSKUModel *sku = [HEBTakOutSKUModel yy_modelWithJSON:obj];
                        NSLog(@"%@", sku.sku_id);
                    }];
                }];
                [foodListArrM addObject:arr];
            }
            
            [weakSelf.buyCarModelArr enumerateObjectsUsingBlock:^(HEBTakOutBuyCarModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HEBTakOutBuyCarModel *buyCar = obj;
                [foodListArrM enumerateObjectsUsingBlock:^(NSMutableArray<HEBTakOutShopModel *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSUInteger f = idx;
                    [obj enumerateObjectsUsingBlock:^(HEBTakOutShopModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        HEBTakOutShopModel *shop = obj;
                        NSUInteger s = idx;
                        if (buyCar.skuattr.length) {
                            [shop.sku enumerateObjectsUsingBlock:^(HEBTakOutSKUModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                HEBTakOutSKUModel *sku = [HEBTakOutSKUModel yy_modelWithJSON:obj];
                                if ([buyCar.skuattr isEqualToString:sku.skuattr] &&
                                    [buyCar.goods_id isEqualToString:shop.food_id]) {
                                    [sku setNum:buyCar.quantity];
                                    [shop.sku replaceObjectAtIndex:idx withObject:[sku yy_modelToJSONObject]];
                                    [foodListArrM[f] replaceObjectAtIndex:s withObject:shop];
                                }
                            }];
                        }else {
                            if ([buyCar.goods_id isEqualToString:obj.food_id]) {
                             [obj setNum:buyCar.quantity];
                             [foodListArrM[f] replaceObjectAtIndex:idx withObject:obj];
                            }
                        }
                    }];
                }];
            }];
            
            weakSelf.takoutDetailView.foodListArr = foodListArrM;
            weakSelf.takoutDetailView.footListView.foodListArr = foodListArrM.firstObject;
            weakSelf.takoutDetailView.footListView.name = filterTypeStrArr.firstObject;
            [weakSelf.takoutDetailView.footListView reloadData];
            
            weakSelf.takoutDetailView.buyCarView.freight.text = [NSString stringWithFormat:@"另需配送费¥%@元", shopModel.shop.delivery];
            weakSelf.takoutDetailView.buyCarView.lowestPrice.text = [NSString stringWithFormat:@"¥%@起送", shopModel.shop.uptosend];
            NSLog(@"%f", weakSelf.shopMoney);
            if (weakSelf.shopMoney >= shopModel.shop.uptosend.floatValue) {
                [weakSelf.takoutDetailView.buyCarView show];
            }
        }
    }];
}

- (void)loadShopCommentariesNetworking {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:ShopINFO params:@{@"shopid":self.shop_id, @"index_page":[NSString stringWithFormat:@"%d", self.page]} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        //店铺信息
        [weakSelf shopINFONetworking];
        [weakSelf.takoutDetailView.allCommentsView.mj_footer endRefreshing];
        [weakSelf.takoutDetailView.allCommentsView.mj_header endRefreshing];
        if (mainModel.status) {
            if ([mainModel.data count] == PSC && weakSelf.page != 1) {
                weakSelf.page++;
                [weakSelf.takoutDetailView.allCommentsView.mj_footer resetNoMoreData];
                [weakSelf.takoutDetailView.allCommentsView.cellModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBPackageDetailsAppraiseModel class] json:mainModel.data]];
            }
            if ([mainModel.data count] == PSC && weakSelf.page == 1) {
                [weakSelf.takoutDetailView.allCommentsView.cellModelArrM removeAllObjects];
                weakSelf.page++;
                [weakSelf.takoutDetailView.allCommentsView.mj_footer resetNoMoreData];
                [weakSelf.takoutDetailView.allCommentsView.cellModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBPackageDetailsAppraiseModel class] json:mainModel.data]];
            }
            if ([mainModel.data count] < PSC && weakSelf.page == 1) {
                [weakSelf.takoutDetailView.allCommentsView.cellModelArrM removeAllObjects];
                [weakSelf.takoutDetailView.allCommentsView.cellModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBPackageDetailsAppraiseModel class] json:mainModel.data]];
                [weakSelf.takoutDetailView.allCommentsView.mj_footer endRefreshingWithNoMoreData];
            }
            if ([mainModel.data count] < PSC && weakSelf.page != 1) {
                [weakSelf.takoutDetailView.allCommentsView.cellModelArrM addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HEBPackageDetailsAppraiseModel class] json:mainModel.data]];
                [weakSelf.takoutDetailView.allCommentsView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.takoutDetailView.allCommentsView reloadData];
        }else {
            [weakSelf.takoutDetailView.allCommentsView.mj_footer endRefreshingWithNoMoreData];
            [weakSelf.takoutDetailView.allCommentsView.cellModelArrM removeAllObjects];
            [weakSelf.takoutDetailView.allCommentsView reloadData];
        }
    }];
}

- (void)shopINFONetworking {
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:TakOutShopActive params:@{@"id":self.shop_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        if (mainModel.status) {
            HEBTakOutShopActiveINFOModel *model = [HEBTakOutShopActiveINFOModel yy_modelWithJSON:mainModel.data];
            [weakSelf.takoutDetailView.shopActiveView.headerView.address setTitle:model.address forState:UIControlStateNormal];
            weakSelf.takoutDetailView.shopActiveView.headerView.shopPicView.cellModelArr = model.shoppic;
            [weakSelf.takoutDetailView.shopActiveView.headerView.shopPicView reloadData];            
            NSString *des = model.shopCoupon.count?[NSString stringWithFormat:@"%ld个优惠活动", model.shopCoupon.count]:@"暂无优惠活动";
            weakSelf.takoutDetailView.shopActiveView.shopINFOArr = @[@[
  @{@"img":@"外卖_配送服务",
    @"title":@"配送服务:",
    @"des": model.send_status
    },
  @{@"img":@"外卖_配送时间",
    @"title":@"配送时间:",
    @"des":[NSString stringWithFormat:@"%@-%@", model.dctime1, model.dctime2]
    }],
    @[@{@"img":@"外卖_优惠活动",
        @"title":@"优惠活动",
        @"des":des,
        @"arr":model.shopCoupon}]];
            [weakSelf.takoutDetailView.shopActiveView reloadData];
            
            [weakSelf.takoutDetailView.shopActiveView.headerView.address addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                HEBMapViewController *map = [[HEBMapViewController alloc] init];
                map.shopName = model.name;
                map.lat = model.lat.doubleValue;
                map.lon = model.lng.doubleValue;
                map.address = model.address;
                [weakSelf.navigationController pushViewController:map animated:YES];
            }];
            [weakSelf.takoutDetailView.shopActiveView.headerView.callPhone addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", model.phone]]];
            }];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = UIColorWhite;
    [self setNavigationBarTransparence];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
    [self.takoutDetailView.buyCarCargoView removeFromSuperview];
    self.takoutDetailView.buyCarCargoView = nil;
}


- (NSArray<HEBTakOutDetailToolsModel *> *)toolsArr {
    if (!_toolsArr) {
        _toolsArr = [NSArray array];
    }
    return _toolsArr;
}

- (NSArray<HEBTakOutBuyCarModel *> *)buyCarModelArr {
    if (!_buyCarModelArr) {
        _buyCarModelArr = [NSArray array];
    }
    return _buyCarModelArr;
}

@end
