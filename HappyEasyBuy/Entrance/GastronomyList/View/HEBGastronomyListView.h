//
//  HEBGastronomyListView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/24.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBFoodStoresView.h"

@interface HEBGastronomyListView : QMUITableView

/** 美食店铺数据源 */
@property(nonatomic, strong) NSMutableArray<HEBFoodStoresModel *> *foodStoresModelArrM;

@end
