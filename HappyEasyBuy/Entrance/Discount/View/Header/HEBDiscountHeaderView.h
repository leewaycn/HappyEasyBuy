//
//  HEBDiscountHeaderView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBDiscountHeaderView : QMUIView

/** 0:通用；1:商家 */
@property(nonatomic, copy) void (^discountDidClick)(BOOL type);

@end
