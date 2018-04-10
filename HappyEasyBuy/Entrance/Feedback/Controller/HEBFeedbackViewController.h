//
//  HEBFeedbackViewController.h
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBFeedbackViewController : HEBBaseViewController

@property(nonatomic, copy) void (^getConnect)(NSString *msg);

@end
