//
//  HEBIntegratedMallGoodsDetailModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBIntegratedMallGoodsDetailModel : NSObject

/** 是否为实物 */
@property(nonatomic, assign) BOOL model;

/** 商品id/优惠券id */
@property(nonatomic, copy) NSString *goods_id;

/** 库存 */
@property(nonatomic, copy) NSString *quantity;

/** 所需积分 */
@property(nonatomic, copy) NSString *integral;

/** 价值 */
@property(nonatomic, copy) NSString *price_origin;

/** 商品名称/优惠券名称 */
@property(nonatomic, copy) NSString *name;

/** 详情 */
@property(nonatomic, copy) NSString *content;

/** 商品品牌 */
@property(nonatomic, copy) NSString *brand_name;

/** 图片 */
@property(nonatomic, copy) NSString *goods_pic;

/** 满额 */
@property(nonatomic, copy) NSString *fullmoney;

/** 减额 */
@property(nonatomic, copy) NSString *reducemoney;

/** 有效期 */
@property(nonatomic, copy) NSString *effective;

@end
