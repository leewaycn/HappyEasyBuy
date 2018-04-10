//
//  HEBTakOutFoodListCell.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/9.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBTakOutFoodListCell : QMUITableViewCell

- (void)setCellINFO;

/** 食品图片 */
@property(nonatomic, strong) UIImageView *icon;

/** 商品名称 */
@property(nonatomic, strong) QMUILabel *name;

/** 现价 */
@property(nonatomic, strong) QMUILabel *price;

/** 原价 */
@property(nonatomic, strong) QMUILabel *oprice;

/** 规格 */
@property(nonatomic, strong) QMUIButton *sku;

/** 增加 */
@property(nonatomic, strong) QMUIButton *add;

/** 数量 */
@property(nonatomic, strong) QMUILabel *count;

/** 减少 */
@property(nonatomic, strong) QMUIButton *subtraction;

/** 获取商品数量变化 */
@property(nonatomic, copy) void (^getShopCountChange)(int count);

@end
