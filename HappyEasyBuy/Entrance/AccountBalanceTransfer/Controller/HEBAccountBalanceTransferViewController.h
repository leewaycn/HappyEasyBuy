//
//  HEBAccountBalanceTransferViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBAccountBalanceTransferViewController : HEBBaseViewController

@property(nonatomic, copy) void (^paySuccess)(NSString *money);

@end
