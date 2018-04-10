//
//  HEBShopDetailsView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/25.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBShopDetailsHeaderView.h"
#import "HEBSetMealView.h"
#import "HEBGetCouponsView.h"

@interface HEBShopDetailsView : QMUITableView

/** 头部视图 */
@property(nonatomic, strong) HEBShopDetailsHeaderView *headerView;

/** 套餐数据源 */
@property(nonatomic, strong) NSArray<HEBShopSetMealModel *> *setMealArr;

@property(nonatomic, strong) NSArray<HEBGetCouponsModel *> *couponsArr;

@end
