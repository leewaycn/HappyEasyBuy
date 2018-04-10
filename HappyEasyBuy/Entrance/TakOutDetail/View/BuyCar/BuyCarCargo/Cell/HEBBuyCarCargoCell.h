//
//  HEBBuyCarCargoCell.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/13.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBBuyCarCargoCell : QMUITableViewCell

/** 商品图片 */
@property(nonatomic, strong) UIImageView *icon;

/** 商品名称 */
@property(nonatomic, strong) QMUILabel *name;

/** 规格 */
@property(nonatomic, strong) QMUILabel *sku;

/** 实际单价 */
@property(nonatomic, strong) QMUILabel *price;

/** 店铺单价 */
@property(nonatomic, strong) QMUILabel *oprice;

/** 增加 */
@property(nonatomic, strong) QMUIButton *add;

/** 数量 */
@property(nonatomic, strong) QMUILabel *count;

/** 减少 */
@property(nonatomic, strong) QMUIButton *subtraction;

/** 获取商品数量变化 */
@property(nonatomic, copy) void (^getShopCountChange)(int count);

- (void)setCellINFO;

@end
