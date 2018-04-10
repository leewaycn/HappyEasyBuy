//
//  HEBOrderPayViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBOrderPayViewController : HEBBaseViewController

/** 因某些特殊需求使用 */
@property(nonatomic, copy) NSString *vcTitle;

/** 因某些特殊需求使用 */
@property(nonatomic, copy) NSString *vcPayMsg;

/** 乐享币数量 */
@property(nonatomic, copy) NSString *consume_num;


/** 是否隐藏头部视图/默认为NO */
@property(nonatomic, assign) BOOL isHiddenHeader;

/** 支付金额 */
@property(nonatomic, copy) NSString *money;

/** 支付的商品 */
@property(nonatomic, copy) NSString *objName;

/** 商品图片 */
@property(nonatomic, copy) NSString *img;

/** 订单号 */
@property(nonatomic, copy) NSString *orderNumber;

/** 微信支付时需要此参数 */
@property(nonatomic, copy) NSString *weChatPayFlag;

/** 支付宝支付时需要此参数 */
@property(nonatomic, copy) NSString *aliPayHost;

/** 支付宝支付时后台字段名不同，所以需要此参数 */
@property(nonatomic, copy) NSString *aliPayKey;

/** 输入支付密码时的提示文字 */
@property(nonatomic, copy) NSString *payMsg;

/** 支付成功时的提示文字 */
@property(nonatomic, copy) NSString *paySuccessMsg;

/** 余额支付 */
@property(nonatomic, copy) NSString *balancePayHost;

/** 余额请求参数 */
@property(nonatomic, strong) NSDictionary *balanceParams;

/** 乐享币支付 */
@property(nonatomic, copy) NSString *happyMoneyPayHost;

/** 乐享币请求参数 */
@property(nonatomic, strong) NSDictionary *happyMoneyParmas;

/**********************以下为美食买单需要的信息*************************/

/** 微信请求地址 */
@property(nonatomic, copy) NSString *weChatPayHost;

/** 商铺id */
@property(nonatomic, copy) NSString *shopid;

/** 买单类型 */
@property(nonatomic, copy) NSString *type;

/** 总价 */
@property(nonatomic, copy) NSString *total_price;

/** 支付价 */
@property(nonatomic, copy) NSString *pay_price;

/** 优惠金额 */
@property(nonatomic, copy) NSString *re_money;

/** 店铺名称 */
@property(nonatomic, copy) NSString *shopName;

/** 因某些页面的特殊性，需要单独处理成功的逻辑 */
@property(nonatomic, copy) void (^paySuccess)(void);

@end
