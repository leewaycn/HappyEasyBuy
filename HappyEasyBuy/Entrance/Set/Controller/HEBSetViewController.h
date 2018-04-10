//
//  HEBSetViewController.h
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBSetViewController : HEBBaseViewController

/** 退出登录 */
@property(nonatomic, copy) void (^Logout)(BOOL success);

@end
