//
//  HEBOrderPayHeaderView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBOrderPayHeaderView : QMUIView

/** 套餐图片 */
@property(nonatomic, strong) UIImageView *icon;

/** 套餐名称 */
@property(nonatomic, strong) QMUILabel *name;

/** 价格 */
@property(nonatomic, strong) QMUILabel *money;

@end
