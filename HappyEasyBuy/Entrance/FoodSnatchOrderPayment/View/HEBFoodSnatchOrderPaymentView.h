//
//  HEBFoodSnatchOrderPaymentView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBFoodSnatchOrderPaymentHeaderView.h"
#import "HEBFoodSnatchOrderPaymentModel.h"

@interface HEBFoodSnatchOrderPaymentView : QMUITableView

/** 头部视图 */
@property(nonatomic, strong) HEBFoodSnatchOrderPaymentHeaderView *header;

/** 店铺优惠 */
@property(nonatomic, strong) NSArray<HEBFoodSnatchOrderPaymentCouponDetailModel *> *shopReduceArr;

/** 通用优惠券 */
@property(nonatomic, strong) NSArray<HEBFoodSnatchOrderPaymentRedDetailModel *> *redArr;

/** 手机号 */
@property(nonatomic, strong) QMUITextField *phoneNum;

/** 获取cell的点击 */
@property(nonatomic, copy) void (^getCellDidClick)(NSString *title);

@end
