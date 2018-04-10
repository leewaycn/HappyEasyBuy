//
//  HEBBalanceRecordModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/11.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBBalanceRecordModel : NSObject

/** 充值方式weixin：微信支付 alipay:支付宝支付 */
@property(nonatomic, copy) NSString *payway;

/** 充值金额 */
@property(nonatomic, copy) NSString *price;

/** 时间 */
@property(nonatomic, copy) NSString *time;

/** 订单号 */
@property(nonatomic, copy) NSString *orderid;

/** 0：取消申请，1：审核中，2：提现成功 */
@property(nonatomic, copy) NSString *status;

/** 银行 */
@property(nonatomic, copy) NSString *txyh;

/** 提现卡号 */
@property(nonatomic, copy) NSString *txcard;

/** 接受转账的账号 */
@property(nonatomic, copy) NSString *username;

@end
