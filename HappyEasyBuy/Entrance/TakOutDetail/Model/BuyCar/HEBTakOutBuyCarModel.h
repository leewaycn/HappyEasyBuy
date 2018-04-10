//
//  HEBTakOutBuyCarModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/15.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBTakOutBuyCarModel : NSObject

/** 数量 */
@property(nonatomic, assign) int quantity;

/** 规格名 */
@property(nonatomic, copy) NSString *skuattr;

/** 规格 */
@property(nonatomic, copy) NSString *sku;

/** 价格 */
@property(nonatomic, copy) NSString *price;

/** 起送价 */
@property(nonatomic, copy) NSString *uptosend;

/** 商品名 */
@property(nonatomic, copy) NSString *name;

/** 商品id */
@property(nonatomic, copy) NSString *goods_id;

/** 图片 */
@property(nonatomic, copy) NSString *pic;

@end
