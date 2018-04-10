//
//  HEBOrderTakOutDetailCell.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBOrderTakOutDetailCell : QMUIView

/** 商品图片 */
@property(nonatomic, strong) UIImageView *icon;

/** 数量 */
@property(nonatomic, strong) QMUILabel *count;

/** 价格 */
@property(nonatomic, strong) QMUILabel *money;

@end
