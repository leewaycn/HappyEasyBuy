//
//  HEBFoodStoresModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/23.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBFoodStoresModel : NSObject

/** 店铺id */
@property(nonatomic, copy) NSString *shopid;

/** 店铺名 */
@property(nonatomic, copy) NSString *name;

/** 店铺logoID */
@property(nonatomic, copy) NSString *logo;

/** 店铺logo图 */
@property(nonatomic, copy) NSString *imgurl;

/** 店铺地址 */
@property(nonatomic, copy) NSString *address;

/** 当前经度 */
@property(nonatomic, copy) NSString *lng;

/** 当前纬度 */
@property(nonatomic, copy) NSString *lat;

/** 分类id */
@property(nonatomic, copy) NSString *cate_id;

/** 人均价 */
@property(nonatomic, copy) NSString *avgprice;

/** 最低价 */
@property(nonatomic, copy) NSString *base_price;

/** 排序用（距离） */
@property(nonatomic, copy) NSString *distances;

/** 距离 */
@property(nonatomic, copy) NSString *distance;

/** 评分 */
@property(nonatomic, assign) float score;

@end
