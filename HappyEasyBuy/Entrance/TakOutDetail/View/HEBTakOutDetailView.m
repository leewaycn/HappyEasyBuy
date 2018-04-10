//
//  HEBTakOutDetailView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/8.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutDetailView.h"
#import "HEBTakOutDetailToolsView.h"
#import "HEBGetCouponsView.h"
#import "HEBGetCouponsModel.h"

@interface HEBTakOutDetailView ()

@property(nonatomic, strong) HEBTakOutDetailToolsView *toolsView;

/** 记录购物车商品数量 */
@property(nonatomic, assign) NSInteger count;

/** 记录购物车商品总价 */
@property(nonatomic, assign) CGFloat money;

/** 记录当前选中行 */
@property(nonatomic, assign) NSInteger selectRow;

/** 主体视图容器 */
@property(nonatomic, strong) UIScrollView *scrollerView;

@end

@implementation HEBTakOutDetailView

- (void)loadView {
    [self loadShopINFOView];
    [self loadHeaderToolsView];
    [self loadScroller];
    [self loadFilterTypeView];
    [self loadFoodListView];
    [self loadAllCommentsView];
    [self loadShopActiveView];
    self.selectRow = 0;
}

- (void)loadShopINFOView {
    HEBTakOutShopINFOView *shopINFOView = [[HEBTakOutShopINFOView alloc] init];
    selfClass(shopINFOView);
    [self addSubview:shopINFOView];
    [shopINFOView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_offset(IS_58INCH_SCREEN?200:160);
    }];
}

- (void)loadHeaderToolsView {
    HEBTakOutDetailToolsView *toolsView = [[HEBTakOutDetailToolsView alloc] init];
    selfClass(toolsView);
    [self addSubview:toolsView];
    [toolsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.shopINFOView.mas_bottom);
        make.height.mas_offset(44);
    }];
}

- (void)loadScroller {
    UIScrollView *scrollerView = [[UIScrollView alloc] init];
    scrollerView.scrollEnabled = NO;
    selfClass(scrollerView);
    scrollerView.pagingEnabled = YES;
    scrollerView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollerView];
    [scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.toolsView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    [scrollerView setContentSize:CGSizeMake(SCREEN_WIDTH*3, 0)];
    __weak __typeof(self)weakSelf = self;
    self.toolsView.getTakOutToolsDidClick = ^(NSInteger idx) {
        [weakSelf.buyCarCargoView removeFromSuperview];
        weakSelf.buyCarCargoView = nil;
        [weakSelf.scrollerView setContentOffset:CGPointMake(idx*SCREEN_WIDTH, 0) animated:YES];
    };
}

- (void)loadFilterTypeView {
    HEBFilterTypeView *filterTypeView = [[HEBFilterTypeView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    selfClass(filterTypeView);
    [self.scrollerView addSubview:filterTypeView];
    [filterTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollerView.mas_left);
        make.top.equalTo(self.toolsView.mas_bottom);
        make.width.mas_offset(SCREEN_WIDTH/4);
        make.bottom.equalTo(self.mas_bottom).offset(-70);
    }];
    __weak __typeof(self)weakSelf = self;
    filterTypeView.getFilterType = ^(NSInteger idx, NSString *name) {
        weakSelf.selectRow = idx;
        weakSelf.footListView.name = name;
        weakSelf.footListView.foodListArr = weakSelf.foodListArr[idx];
        [weakSelf.footListView reloadData];
    };
}

- (void)loadFoodListView {
    HEBTakOutFoodListView *footListView = [[HEBTakOutFoodListView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(footListView);
    [self.scrollerView addSubview:footListView];
    [footListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.filterTypeView);
        make.left.equalTo(self.filterTypeView.mas_right);
        make.width.mas_offset(SCREEN_WIDTH-(SCREEN_WIDTH/4));
    }];
    
    HEBBuyCarView *buyCarView = [[HEBBuyCarView alloc] init];
    selfClass(buyCarView);
    [self.scrollerView addSubview:buyCarView];
    [buyCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(footListView.mas_bottom);
        make.left.equalTo(self.filterTypeView.mas_left);
        make.right.equalTo(self.footListView.mas_right);
    }];
    [buyCarView.buyCar addTarget:self action:@selector(buyCarDidClick) forControlEvents:UIControlEventTouchUpInside];
    __weak __typeof(self)weakSelf = self;
    footListView.getFoodListChnage = ^(NSArray<HEBTakOutSKUModel *> *skuModelArr, NSInteger skuTag, NSInteger cellTag, NSString *food_id, NSInteger count, NSString *sku) {
        NSLog(@"%ld---%@---%@", count, food_id, sku);
             [weakSelf updateShopBuyCarDataBaseCount:[NSString stringWithFormat:@"%ld", count] withGoods_id:food_id sku:sku];
        weakSelf.count = 0;
        weakSelf.money = 0.00;
        HEBTakOutShopModel *shopModel = weakSelf.foodListArr[weakSelf.selectRow][cellTag];
        [shopModel setSku:(id)skuModelArr];
        [weakSelf.foodListArr[weakSelf.selectRow] replaceObjectAtIndex:cellTag withObject:shopModel];
        [weakSelf.foodListArr enumerateObjectsUsingBlock:^(NSMutableArray<HEBTakOutShopModel *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj enumerateObjectsUsingBlock:^(HEBTakOutShopModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (!obj.sku.count) {
                    weakSelf.count = weakSelf.count+obj.num;
                    weakSelf.money = obj.num*obj.price.floatValue+weakSelf.money;
                    NSLog(@"----->%.2f", weakSelf.money);
                }else {
                    NSLog(@"<----->%.2f", weakSelf.money);
                    [obj.sku enumerateObjectsUsingBlock:^(HEBTakOutSKUModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        HEBTakOutSKUModel *skuModel = [HEBTakOutSKUModel yy_modelWithJSON:obj];
                        weakSelf.count = weakSelf.count+skuModel.num;
                        weakSelf.money = weakSelf.money+skuModel.num*skuModel.price.floatValue;
                        NSLog(@"<------%.2f", weakSelf.money);
                    }];
                }
            }];
        }];
        [weakSelf buyCarINFOChange];
    };
    
    footListView.getNotSKUCoutChange = ^(int shopCount, NSInteger cellTag, NSString *food_id) {
        [weakSelf updateShopBuyCarDataBaseCount:[NSString stringWithFormat:@"%d", shopCount] withGoods_id:food_id sku:nil];
        weakSelf.count = 0;
        weakSelf.money = 0.00;
        HEBTakOutShopModel *shopModel = weakSelf.foodListArr[weakSelf.selectRow][cellTag];
        [shopModel setNum:shopCount];
        [weakSelf.foodListArr[weakSelf.selectRow] replaceObjectAtIndex:cellTag withObject:shopModel];
        [weakSelf.foodListArr enumerateObjectsUsingBlock:^(NSMutableArray<HEBTakOutShopModel *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj enumerateObjectsUsingBlock:^(HEBTakOutShopModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (!obj.sku.count) {
                    weakSelf.count = weakSelf.count+obj.num;
                    weakSelf.money = obj.num*obj.price.floatValue+weakSelf.money;
                }else {
                    [obj.sku enumerateObjectsUsingBlock:^(HEBTakOutSKUModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        HEBTakOutSKUModel *skuModel = [HEBTakOutSKUModel yy_modelWithJSON:obj];
                        weakSelf.count = weakSelf.count+skuModel.num;
                        weakSelf.money = weakSelf.money+skuModel.num*skuModel.price.floatValue;
                    }];
                }
            }];
        }];
        [weakSelf buyCarINFOChange];
    };
    
}

- (void)buyCarDidClick {
    __weak __typeof(self)weakSelf = self;
    if (self.buyCarCargoView) {
        [UIView animateWithDuration:1.25 animations:^{
            weakSelf.buyCarCargoView.top = SCREEN_HEIGHT;
        } completion:^(BOOL finished) {
            [weakSelf.buyCarCargoView removeFromSuperview];
            weakSelf.buyCarCargoView = nil;
        }];
        return;
    }
    NSMutableArray<HEBTakOutShopModel *> *arrM = [NSMutableArray array];
    [self.foodListArr enumerateObjectsUsingBlock:^(NSArray<HEBTakOutShopModel *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger f = idx;
        [obj enumerateObjectsUsingBlock:^(HEBTakOutShopModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HEBTakOutShopModel *shopModel = obj;
            NSInteger t = idx;
            if (!obj.sku.count && obj.num) {
                NSString *sub = [NSString stringWithFormat:@"%ld,%ld", f, t];
                [obj setSubscript:sub];
                [obj setSkuNum:obj.num];
                [obj setSkuName:obj.name];
                [obj setSkuPrice:obj.price];
                [arrM addObject:obj];
                return ;
            }
            [obj.sku enumerateObjectsUsingBlock:^(HEBTakOutSKUModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HEBTakOutSKUModel *skuModel = [HEBTakOutSKUModel yy_modelWithJSON:obj];
                if (skuModel.num) {
                    HEBTakOutShopModel *model = [[HEBTakOutShopModel alloc] init];
                    [model setPic:shopModel.pic];
                    [model setOprice:shopModel.oprice];
                    NSString *sub = [NSString stringWithFormat:@"%ld,%ld,%ld", f, t, idx];
                    [model setSubscript:sub];
                    [model setName:shopModel.name];
                    [model setSku_id:skuModel.sku_id];
                    [model setSkuNum:skuModel.num];
                    [model setSkuPrice:skuModel.price];
                    [model setSkuName:skuModel.skuattr];
                    [model setSku_sku:skuModel.sku];
                    [model setFood_id:shopModel.food_id];
                    [arrM addObject:model];
                }
            }];
        }];
    }];
    HEBBuyCarCargoView *buyCarCargoView = [[HEBBuyCarCargoView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-(IS_58INCH_SCREEN?314:274), SCREEN_WIDTH, SCREEN_HEIGHT-(IS_58INCH_SCREEN?314:274)) style:UITableViewStylePlain];
    selfClass(buyCarCargoView);
    buyCarCargoView.foodListArr = arrM;
    [self.scrollerView addSubview:buyCarCargoView];
    [self.scrollerView bringSubviewToFront:self.buyCarView];
    [UIView animateWithDuration:1.25 animations:^{
        weakSelf.buyCarCargoView.top = 0;
    }];
    buyCarCargoView.getBuyCarShopChange = ^(NSArray<HEBTakOutShopModel *> *foodListArr, BOOL isNil, NSString *food_id, int count, NSString *sku) {
        [weakSelf updateShopBuyCarDataBaseCount:[NSString stringWithFormat:@"%d", count] withGoods_id:food_id sku:sku];
        weakSelf.count = 0;
        weakSelf.money = 0.00;
        if (isNil) {
            [weakSelf buyCarDidClick];
        }
        [foodListArr enumerateObjectsUsingBlock:^(HEBTakOutShopModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            weakSelf.count = obj.skuNum+weakSelf.count;
            weakSelf.money = obj.skuPrice.floatValue*obj.skuNum+weakSelf.money;
            NSArray<NSString *> *arridx = [obj.subscript componentsSeparatedByString:@","];
            NSMutableArray<HEBTakOutShopModel *> *foodListArrM = weakSelf.foodListArr[arridx[0].integerValue];
            if (arridx.count == 2) {
                [obj setNum:obj.skuNum];
                [weakSelf.foodListArr[arridx[0].integerValue] replaceObjectAtIndex:arridx[1].integerValue withObject:obj];
                weakSelf.footListView.foodListArr = weakSelf.foodListArr[weakSelf.selectRow];
                [weakSelf.footListView reloadData];
            }else {
                HEBTakOutShopModel *shopModel = foodListArrM[arridx[1].integerValue];
                HEBTakOutSKUModel *skuModel = [HEBTakOutSKUModel yy_modelWithJSON:shopModel.sku[arridx[2].integerValue]];
                [skuModel setNum:obj.skuNum];
                [weakSelf.foodListArr[arridx[0].integerValue][arridx[1].integerValue].sku replaceObjectAtIndex:arridx[2].integerValue withObject:[skuModel yy_modelToJSONObject]];
            }
        }];
        [weakSelf buyCarINFOChange];
    };
}

- (void)buyCarINFOChange {
    self.buyCarView.num.hidden = !self.count;
    self.buyCarView.buyCar.userInteractionEnabled = self.count;
    self.buyCarView.money.text = [NSString stringWithFormat:@"总价¥%.2f", self.money];
    if (self.count) {
        self.buyCarView.num.text = [NSString stringWithFormat:@"%ld", self.count];
        self.buyCarView.buyCarBGView.backgroundColor = UIColorBlack;
        [self.buyCarView.buyCar setBackgroundImage:UIImageMake(@"外卖_购物车可用") forState:UIControlStateNormal];
        if (self.money >= [self.buyCarView.lowestPrice.text.removeMoneySymbol stringByReplacingOccurrencesOfString:@"起送" withString:@""].floatValue) {
            [self.buyCarView show];
            __weak __typeof(self)weakSelf = self;
            [self.buyCarView.pay addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                HEBTakOutOrderDetailViewController *pay = [[HEBTakOutOrderDetailViewController alloc] init];
                pay.shop_id = weakSelf.shop_id;
                pay.money = [NSString stringWithFormat:@"%@", [weakSelf.buyCarView.money.text stringByReplacingOccurrencesOfString:@"总价¥" withString:@""]];
                [weakSelf.viewController.navigationController pushViewController:pay animated:YES];
            }];
        }else {
            [self.buyCarView hidden];
        }
    }else {
        [self.buyCarView hidden];
        [self.buyCarView.buyCar setBackgroundImage:UIImageMake(@"外卖_购物车") forState:UIControlStateNormal];
        self.buyCarView.buyCarBGView.backgroundColor = UIColorHex(#545454);
    }
}

- (void)loadAllCommentsView {
    HEBAllCommentsView *allCommentsView = [[HEBAllCommentsView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    selfClass(allCommentsView);
    [self.scrollerView addSubview:allCommentsView];
    [allCommentsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.toolsView.mas_bottom);
        make.left.equalTo(self.scrollerView.mas_left).offset(SCREEN_WIDTH);
        make.width.mas_offset(SCREEN_WIDTH);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (void)loadShopActiveView {
    HEBShopActiveView *shopActiveView = [[HEBShopActiveView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(shopActiveView);
    [self.scrollerView addSubview:shopActiveView];
    [shopActiveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.toolsView.mas_bottom);
        make.left.equalTo(self.scrollerView.mas_left).offset(SCREEN_WIDTH*2);
        make.width.mas_offset(SCREEN_WIDTH);
        make.bottom.equalTo(self.mas_bottom);
    }];
    __weak __typeof(self)weakSelf = self;
    shopActiveView.getCoupon = ^(BOOL isDidClick) {
        [((HEBBaseViewController *)weakSelf.viewController).progressHUD showAnimated:YES];
        [Networking postUrl:CouponList params:@{@"shop_id":weakSelf.shop_id, @"shop_type":@"5"} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
            [((HEBBaseViewController *)weakSelf.viewController) dismissProgressHUD];
            if (mainModel.status) {
                HEBGetCouponsView *getCoupons = [[HEBGetCouponsView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
                getCoupons.cellModelArr = [NSArray yy_modelArrayWithClass:[HEBGetCouponsModel class] json:mainModel.data];
                [self.window addSubview:getCoupons];
                [UIView animateWithDuration:1.25 animations:^{
                    getCoupons.top = 0;
                }];
                @weakify(getCoupons);
                getCoupons.getDidSelectCoupons = ^(NSString *coupons_id) {
                    if (getUser_id) {
                        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:weak_getCoupons animated:YES];
                        [hub showAnimated:YES];
                        [Networking postUrl:GetCoupon params:@{@"uid":getUser_id, @"cid":coupons_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                            hub.label.text = mainModel.msg;
                            [hub hideAnimated:YES afterDelay:1.25];
                        }];
                    }else {
                        ISAlertNotLoginMessage;
                    }
                };
            }else {
                [ISMessages showCardAlertWithTitle:@"暂无优惠券"
                                           message:@"当前商家暂未推出优惠券"
                                          duration:2.25
                                       hideOnSwipe:NO
                                         hideOnTap:NO
                                         alertType:(ISAlertTypeInfo)
                                     alertPosition:(ISAlertPositionTop) didHide:nil];
            }
        }];
    };
}

- (void)updateShopBuyCarDataBaseCount:(NSString *)count withGoods_id:(NSString *)good_id sku:(NSString *)sku {
    if (getUser_id) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:getUser_id forKey:@"user_id"];
        [params setObject:self.shop_id forKey:@"shop_id"];
        [params setObject:count forKey:@"quantity"];
        [params setObject:good_id forKey:@"goods_id"];
        if (sku) {
            [params setObject:sku forKey:@"sku"];
        }
        [Networking postUrl:UpDateBuyCar params:params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        }];
    }else {
        ISAlertNotLoginMessage;
    }
    
}

- (NSMutableArray<NSMutableArray<HEBTakOutShopModel *> *> *)foodListArr {
    if (!_foodListArr) {
        _foodListArr = [NSMutableArray array];
    }
    return _foodListArr;
}



@end
