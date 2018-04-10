//
//  HEBConsumedViewController.h
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBHappyMoneyViewController : HEBBaseViewController

/** 乐享币 */
@property(nonatomic, copy) NSString *happyMoney;

@property(nonatomic, copy) void (^getHappyMoney)(NSString *money);

@end
