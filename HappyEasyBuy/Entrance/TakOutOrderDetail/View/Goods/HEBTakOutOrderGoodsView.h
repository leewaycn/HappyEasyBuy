//
//  HEBTakOutOrderGoodsView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBTakOutOrderGoodsView : QMUIView

/** 商品图片 */
@property(nonatomic, strong) UIImageView *icon;

/** 商品名 */
@property(nonatomic, strong) QMUILabel *name;

/** 商品价格 */
@property(nonatomic, strong) QMUILabel *money;

/** 商品数量 */
@property(nonatomic, strong) QMUILabel *count;

@end
