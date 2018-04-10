//
//  HEBPayPasswordViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/3.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBPayPasswordViewController : HEBBaseViewController

/** 订单信息 */
@property(nonatomic, copy) NSString *payMsg;

/** 付款方式 */
@property(nonatomic, copy) NSString *payType;

/** 付款金额 */
@property(nonatomic, copy) NSString *payMoney;

/** 最终的支付地址 */
@property(nonatomic, copy) NSString *payHost;

/** 最终的请求参数 */
@property(nonatomic, strong) NSDictionary *params;

/** 是否支付成功 */
@property(nonatomic, copy) void (^payStatus)(BOOL status);

@property(nonatomic, copy) void (^payStatusStr)(NSString *orderNumber);

@end
