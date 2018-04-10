//
//  HEBAccountBalanceWithdrawalViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBAccountBalanceWithdrawalViewController : HEBBaseViewController

/** 提现成功，账户现有余额 */
@property(nonatomic, copy) void (^withdrawalSuccess)(NSString *money);

@end
