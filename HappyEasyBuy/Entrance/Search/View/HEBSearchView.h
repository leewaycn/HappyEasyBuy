//
//  HEBSearchView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/1.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBFoodStoresView.h"

@interface HEBSearchView : QMUITableView

/** 美食店铺数据源 */
@property(nonatomic, strong) NSArray<HEBFoodStoresModel *> *foodStoresModelArr;

@end
