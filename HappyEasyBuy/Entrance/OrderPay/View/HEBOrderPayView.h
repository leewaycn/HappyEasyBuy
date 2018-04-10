//
//  HEBOrderPayView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBOrderPayHeaderView.h"

@interface HEBOrderPayView : QMUITableView

/** 特殊要求 */
@property(nonatomic, assign) BOOL hasTitle;

/** 顶部视图 */
@property(nonatomic, strong) HEBOrderPayHeaderView *header;

/** 支付 */
@property(nonatomic, strong) QMUIButton *pay;

/** 获取支付方式 */
@property(nonatomic, copy) void (^getPayType)(NSInteger idx);

@end
