//
//  HEBFilterTypeView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/8.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBTakOutDetailModel.h"

@interface HEBFilterTypeView : QMUITableView

/** 筛选 */
@property(nonatomic, strong) NSArray<NSString *> *cellModelArr;

/** 获取点击的cell */
@property(nonatomic, copy) void (^getFilterType)(NSInteger idx, NSString *name);

@end
