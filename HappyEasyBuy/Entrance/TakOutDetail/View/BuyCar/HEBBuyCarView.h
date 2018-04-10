//
//  HEBBuyCarView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/9.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBBuyCarView : QMUIView

/** 购物车背景 */
@property(nonatomic, strong) UIView *buyCarBGView;

/** 购物车🛒 */
@property(nonatomic, strong) QMUIButton *buyCar;

/** 配送费 */
@property(nonatomic, strong) QMUILabel *freight;

/** 起送价 */
@property(nonatomic, strong) QMUILabel *lowestPrice;

/** 总价 */
@property(nonatomic, strong) QMUILabel *money;

/** 数量 */
@property(nonatomic, strong) QMUILabel *num;

/** 结算 */
@property(nonatomic, strong) QMUIButton *pay;

- (void)show;

- (void)hidden;

@end
