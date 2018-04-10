//
//  HEBTakOutOrderDetailViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/15.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBTakOutOrderDetailViewController : HEBBaseViewController

/** 商铺id */
@property(nonatomic, copy) NSString *shop_id;

/** 支付金额 */
@property(nonatomic, copy) NSString *money;

@end
