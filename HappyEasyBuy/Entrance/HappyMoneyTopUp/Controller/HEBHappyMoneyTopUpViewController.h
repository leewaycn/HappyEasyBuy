//
//  HEBHappyMoneyTopUpViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBHappyMoneyTopUpViewController : HEBBaseViewController

@property(nonatomic, copy) void (^getHappyMoney)(NSString *moeny);

@end
