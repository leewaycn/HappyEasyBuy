//
//  HEBTakOutOrderDetailView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/15.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBTakOutOrderDetailModel.h"

@interface HEBTakOutOrderDetailView : QMUITableView

/** 需支付的金额 */
@property(nonatomic, copy) NSString *money;

/** 收货人信息 */
@property(nonatomic, strong) HEBTakOutOrderUseINFOModel *useINFOModel;

/** 店家信息 */
@property(nonatomic, strong) HEBTakOutOrderShopINFOModel *shopINFOModel;

/** 需支付的商品清单 */
@property(nonatomic, strong) NSArray<HEBTakOutBuyCarModel *> *foodlistArr;

/** 优惠券 */
@property(nonatomic, strong) NSArray<NSArray *> *couponsArr;

/** 获取优惠金额 */
@property(nonatomic, copy) void (^getReduceMoney)(CGFloat reduce, NSString *key, NSString *value);

/** 获取地址id */
@property(nonatomic, copy) void (^getAddressid)(NSString *addressid);

/** 获取商品备注信息 */
@property(nonatomic, copy) void (^getMsg)(NSString *msg);

@end
