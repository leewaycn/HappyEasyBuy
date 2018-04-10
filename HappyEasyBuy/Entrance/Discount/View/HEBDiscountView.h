//
//  HEBDiscountView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBDiscountModel.h"

@interface HEBDiscountView : QMUITableView

@property(nonatomic, strong) NSArray<HEBDiscountModel *> *modelArr;

@end
