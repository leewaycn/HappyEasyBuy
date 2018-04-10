//
//  HEBBalanceViewController.h
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBBalanceViewController : HEBBaseViewController

/** 余额 */
@property(nonatomic, copy) NSString *accountBalance;

/** 提现成功，账户现有余额 */
@property(nonatomic, copy) void (^withdrawalSuccess)(NSString *money);

@property(nonatomic, copy) void (^topuoSuccess)(NSString *money);

@end
