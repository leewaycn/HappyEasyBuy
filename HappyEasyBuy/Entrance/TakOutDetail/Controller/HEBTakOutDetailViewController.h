//
//  HEBTakOutDetailViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/8.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBTakOutDetailViewController : HEBBaseViewController

/** 商铺id */
@property(nonatomic, copy) NSString *shop_id;

- (void)loadBuyCarNetworking;

@end
