//
//  HEBOrderFoodDetailHeaderView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBOrderFoodDetailHeaderView : QMUIView

/** 商品图片 */
@property(nonatomic, strong) UIImageView *icon;

/** 套餐名称 */
@property(nonatomic, strong) QMUILabel *name;

/** 套餐简介 */
@property(nonatomic, strong) QMUILabel *des;

/** 价格 */
@property(nonatomic, strong) QMUILabel *money;

@end
