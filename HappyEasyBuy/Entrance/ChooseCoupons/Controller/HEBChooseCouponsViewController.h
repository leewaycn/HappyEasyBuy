//
//  HEBChooseCouponsViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/1.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"
#import "HEBFoodSnatchOrderPaymentModel.h"

@interface HEBChooseCouponsViewController : HEBBaseViewController

/** 当前金额 */
@property(nonatomic, assign) CGFloat money;

/** 店铺优惠 */
@property(nonatomic, strong) NSArray<HEBFoodSnatchOrderPaymentCouponDetailModel *> *shopReduceArr;

/** 通用优惠券 */
@property(nonatomic, strong) NSArray<HEBFoodSnatchOrderPaymentRedDetailModel *> *redArr;

/** 计算实际金额 */
@property(nonatomic, copy) void (^getMoney)(NSString *money, NSString *key, NSString *value);

@end
