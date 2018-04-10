//
//  HEBTakOutFoodListView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/9.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBTakOutSKUView.h"

@interface HEBTakOutFoodListView : QMUITableView

@property(nonatomic, strong) NSMutableArray<HEBTakOutShopModel *> *foodListArr;

/** title */
@property(nonatomic, copy) NSString *name;

/** 获取外卖食物列表的属性变化 */
@property(nonatomic, copy) void (^getFoodListChnage)(NSArray<HEBTakOutSKUModel *> *skuModelArr, NSInteger skuTag, NSInteger cellTag, NSString *food_id, NSInteger count, NSString *sku);

/** 获取无sku商品数量变化 */
@property(nonatomic, copy) void (^getNotSKUCoutChange)(int count, NSInteger cellTag, NSString *food_id);

@end
