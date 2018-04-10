//
//  HEBLocationViewController.h
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"
@class HEBLocationModel;

@interface HEBLocationViewController : HEBBaseViewController

/** 获取收货人信息 */
@property(nonatomic, assign) BOOL getConsignee;

@property(nonatomic, copy) void (^getConsigneeINFO)(HEBLocationModel *model);

@end
