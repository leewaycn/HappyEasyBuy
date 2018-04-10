//
//  HEBAccountBalanceWithdrawalModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBAccountBalanceWithdrawalModel : NSObject

/** 用户余额 */
@property(nonatomic, copy) NSString *balance;

/** 最少提现金额 */
@property(nonatomic, copy) NSString *least;

/** 最大提现金额 */
@property(nonatomic, copy) NSString *most;

/** 提现人名字 */
@property(nonatomic, copy) NSString *txname;

/** 提现人手机号 */
@property(nonatomic, copy) NSString *txmobile;

/** 开户银行 */
@property(nonatomic, copy) NSString *txyh;

/** 所属分行 */
@property(nonatomic, copy) NSString *txfh;

/** 开户银行所在地 */
@property(nonatomic, copy) NSString *txszd;

/** 还可以提现 */
@property(nonatomic, copy) NSString *limit_money;

@end
