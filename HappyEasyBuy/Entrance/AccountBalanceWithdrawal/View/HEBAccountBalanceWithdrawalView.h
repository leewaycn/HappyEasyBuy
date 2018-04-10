//
//  HEBAccountBalanceWithdrawalView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBAccountBalanceWithdrawalModel.h"

@interface HEBAccountBalanceWithdrawalView : QMUITableView

/** 提现信息 */
@property(nonatomic, strong) NSMutableArray<NSDictionary *> *withdrawalINFO;

@property(nonatomic, strong) HEBAccountBalanceWithdrawalModel *model;

/** 提现成功，账户现有余额 */
@property(nonatomic, copy) void (^withdrawalSuccess)(NSString *money);

@end
