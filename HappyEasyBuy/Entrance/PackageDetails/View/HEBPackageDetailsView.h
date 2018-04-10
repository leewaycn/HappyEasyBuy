//
//  HEBPackageDetailsView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBPackageDetailsHeaderView.h"
#import "HEBPackageDetailsModel.h"
#import "HEBPackageDetailsShopINFOView.h"
#import "HEBPackageDetailsAppraiseModel.h"

@interface HEBPackageDetailsView : QMUITableView

/** 顶部视图 */
@property(nonatomic, strong) HEBPackageDetailsHeaderView *header;

/** 商家信息 */
@property(nonatomic, strong) HEBPackageDetailsShopINFOView *shopINFO;

/** 套餐物品数组 */
@property(nonatomic, strong) NSArray<HEBPackageDetailsArticlesModel *> *articlesArr;

/** 有效期 */
@property(nonatomic, copy) NSString *aging;

/** 使用时间 */
@property(nonatomic, copy) NSString *useTime;

/** 使用规则 */
@property(nonatomic, copy) NSString *useRules;

/** 用户评论 */
@property(nonatomic, strong) NSArray<HEBPackageDetailsAppraiseModel *> *appraiseArr;

/** 商铺id */
@property(nonatomic, copy) NSString *shop_id;

@end
