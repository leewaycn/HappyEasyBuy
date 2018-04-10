//
//  HEBLoginViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBLoginViewController : HEBBaseViewController

/** 登录成功后获取用户信息 */
@property(nonatomic, copy) void (^getUserINFO)(NSString *userName, NSString *headerimg);

@end
