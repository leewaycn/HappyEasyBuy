//
//  HEBHotSellModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBHotSellModel : NSObject

/** 商铺ID */
@property(nonatomic, copy) NSString *shop_id;

/** 商品名称 */
@property(nonatomic, copy) NSString *name;

/** 图片地址 */
@property(nonatomic, copy) NSString *pic;

@end
