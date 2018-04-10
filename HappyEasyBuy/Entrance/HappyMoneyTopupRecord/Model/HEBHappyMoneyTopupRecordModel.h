//
//  HEBHappyMoneyTopupRecordModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/10.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBHappyMoneyTopupRecordModel : NSObject

/** 订单编号 */
@property(nonatomic, copy) NSString *orderid;

/** 实付金额 */
@property(nonatomic, copy) NSString *pay_price;

/** 充值的乐享币 */
@property(nonatomic, copy) NSString *consume_num;

/** 支付时间 */
@property(nonatomic, copy) NSString *pay_time;

/** 支付方式：1:微信 2:支付宝  */
@property(nonatomic, assign) int pay_type;

/** 1 : 未付款   2 : 已付款 */
@property(nonatomic, assign) int status;

@end
