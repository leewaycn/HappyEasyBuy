//
//  HEBBuyCarCargoView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/12.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
@class HEBTakOutShopModel;

@interface HEBBuyCarCargoView : QMUITableView

/** 数据源 */
@property(nonatomic, strong) NSMutableArray<HEBTakOutShopModel *> *foodListArr;

/** 获取商品变化 */
@property(nonatomic, copy) void (^getBuyCarShopChange)(NSArray<HEBTakOutShopModel *> *foodListArr, BOOL isNil, NSString *food_id, int count, NSString *sku);

@end
