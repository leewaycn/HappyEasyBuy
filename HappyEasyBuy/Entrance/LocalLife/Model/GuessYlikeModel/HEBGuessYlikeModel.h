//
//  HEBGuessYlikeModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBGuessYlikeModel : NSObject

/** 商家id */
@property(nonatomic, copy) NSString *objid;

/** 商家logo */
@property(nonatomic, copy) NSString *logo;

/** 商家名称 */
@property(nonatomic, copy) NSString *name;

/** 起送价 */
@property(nonatomic, copy) NSString *uptosend;

/** 配送费 */
@property(nonatomic, copy) NSString *delivery;

/** 人均价 */
@property(nonatomic, copy) NSString *avgprice;

/** 商家评分 */
@property(nonatomic, assign) float score;

/** 商家月销量 */
@property(nonatomic, copy) NSString *sales;

/** 商家折扣 */
@property(nonatomic, copy) NSString *discount;

/** 商家优惠 */
@property(nonatomic, copy) NSString *yh_description;

/** 营业状态：0：休息中，1：营业中 */
@property(nonatomic, assign) BOOL is_status;

/** 用户与商家的距离，单位KM */
@property(nonatomic, copy) NSString *distance;

/** 平均配送时间，单位：分钟 */
@property(nonatomic, copy) NSString *del_time;

@end
