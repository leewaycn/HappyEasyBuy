//
//  HEBBalanceView.h
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HEBBalanceHeaderView.h"

@interface HEBBalanceView : QMUITableView

@property(nonatomic, strong) HEBBalanceHeaderView *headerView;

/** 提现成功，账户现有余额 */
@property(nonatomic, copy) void (^withdrawalSuccess)(NSString *money);

@property(nonatomic, copy) void (^topuoSuccess)(NSString *money);

@end
