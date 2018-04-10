//
//  HEBIntegratedMallModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBIntegratedMallModel : NSObject

/** 商品id */
@property(nonatomic, copy) NSString *objid;

/** 0:虚拟／1:实物 */
@property(nonatomic, assign) BOOL model;

/** 商品图片 */
@property(nonatomic, copy) NSString *pic;

/** 商品名称 */
@property(nonatomic, copy) NSString *title;

/** 商品所需积分 */
@property(nonatomic, copy) NSString *integral;

@end
