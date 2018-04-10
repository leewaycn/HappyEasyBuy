//
//  HEBBuyOrderViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/5.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBBuyOrderViewController : HEBBaseViewController

/** 商家类型 */
@property(nonatomic, copy) NSString *type;

/** 商家id */
@property(nonatomic, copy) NSString *shop_id;

/** 商家名称 */
@property(nonatomic, copy) NSString *shopName;

@end
