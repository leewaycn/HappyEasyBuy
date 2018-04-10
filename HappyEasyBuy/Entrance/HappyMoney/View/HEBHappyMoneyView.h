//
//  HEBHappyMoneyView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBBalanceHeaderView.h"

@interface HEBHappyMoneyView : QMUITableView

@property(nonatomic, strong) HEBBalanceHeaderView *headerView;

@property(nonatomic, copy) void (^getHappyMoney)(NSString *money);

@end
