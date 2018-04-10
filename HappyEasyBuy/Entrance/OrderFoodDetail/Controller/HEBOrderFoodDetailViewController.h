//
//  HEBOrderFoodDetailViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBOrderFoodDetailViewController : HEBBaseViewController

/** 订单id */
@property(nonatomic, copy) NSString *orderid;

/** 请求地址 */
@property(nonatomic, copy) NSString *url;



@end
