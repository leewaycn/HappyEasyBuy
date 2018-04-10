//
//  HEBBuyOrderView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/5.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBFoodSnatchOrderPaymentModel.h"

@interface HEBBuyOrderView : QMUITableView

/** 商铺id */
@property(nonatomic, copy) NSString *shopid;

/** 商家名称 */
@property(nonatomic, copy) NSString *shopName;

/** 店铺满减 */
@property(nonatomic, strong) QMUILabel *fullReduction;

/** 需满足金额 */
@property(nonatomic, assign) float full;

/** 减免金额 */
@property(nonatomic, assign) float reduction;

/** 店铺优惠券 */
@property(nonatomic, strong) NSArray<HEBFoodSnatchOrderPaymentCouponDetailModel *> *shopCoupon;

/** 乐享红包 */
@property(nonatomic, strong) NSArray<HEBFoodSnatchOrderPaymentRedDetailModel *> *Coupon;

@end
