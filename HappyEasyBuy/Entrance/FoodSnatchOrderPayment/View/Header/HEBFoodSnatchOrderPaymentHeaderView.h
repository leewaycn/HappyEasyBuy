//
//  HEBFoodSnatchOrderPaymentHeaderView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBFoodSnatchOrderPaymentHeaderView : QMUIView

/** 图片 */
@property(nonatomic, strong) UIImageView *icon;

/** 套餐名称 */
@property(nonatomic, strong) QMUILabel *name;

/** 套餐简介 */
@property(nonatomic, strong) QMUILabel *des;

/** 单价 */
@property(nonatomic, strong) QMUILabel *unitPrice;

/** 数量 */
@property(nonatomic, strong) QMUITextField *count;

/** 总价 */
@property(nonatomic, strong) QMUILabel *money;

/** 获取金额 */
@property(nonatomic, copy) void (^getMoney)(CGFloat money);

@end
