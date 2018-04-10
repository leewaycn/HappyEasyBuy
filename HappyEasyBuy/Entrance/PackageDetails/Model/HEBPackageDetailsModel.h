//
//  HEBPackageDetailsModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HEBPackageDetailsArticlesModel;

@interface HEBPackageDetailsModel : NSObject

/** 套餐ID */
@property(nonatomic, copy) NSString *f_id;

/** 套餐名称 */
@property(nonatomic, copy) NSString *f_name;

/** 名称简介 */
@property(nonatomic, copy) NSString *f_name_account;

/** 现价 */
@property(nonatomic, copy) NSString *f_price;

/** 门店价 */
@property(nonatomic, copy) NSString *f_oprice;

/** 已售 */
@property(nonatomic, copy) NSString *f_sold;

/** 有效期开始时间 */
@property(nonatomic, copy) NSString *f_starttime;

/** 有效期结束时间 */
@property(nonatomic, copy) NSString *f_endtime;

/** 使用开始时间 */
@property(nonatomic, copy) NSString *f_starttime1;

/** 使用结束时间 */
@property(nonatomic, copy) NSString *f_endtime1;

/** 使用规则 */
@property(nonatomic, copy) NSString *f_rule;

/** 所属店铺ID */
@property(nonatomic, copy) NSString *shop_id;

/** 距离 */
@property(nonatomic, copy) NSString *distance;

/** 店铺名称 */
@property(nonatomic, copy) NSString *name;

/** 店铺地址 */
@property(nonatomic, copy) NSString *address;

/** 店铺手机号 */
@property(nonatomic, copy) NSString *phone;

/** 店铺详情图片 */
@property(nonatomic, assign) NSArray<NSString *> *imgurl;

/** 套餐规格 */
@property(nonatomic, copy) NSArray<HEBPackageDetailsArticlesModel *> *package;

@end

@interface HEBPackageDetailsArticlesModel : NSObject

/** 商品ID */
@property(nonatomic, copy) NSString *t_id;

/** 商品名称 */
@property(nonatomic, copy) NSString *t_name;

/** 商品数量 */
@property(nonatomic, copy) NSString *t_num;

/** 商品价格 */
@property(nonatomic, copy) NSString *t_price;

@end

