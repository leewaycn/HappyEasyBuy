//
//  HEBGetCouponsView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"
#import "HEBGetCouponsModel.h"

@interface HEBGetCouponsView : QMUIView

/** 优惠券数据源 */
@property(nonatomic, strong) NSArray<HEBGetCouponsModel *> *cellModelArr;

/** 获取选中优惠券的id */
@property(nonatomic, copy) void (^getDidSelectCoupons)(NSString *coupons_id);

@end
