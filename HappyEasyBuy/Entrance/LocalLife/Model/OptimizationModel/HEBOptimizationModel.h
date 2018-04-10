//
//  HEBOptimizationModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBOptimizationModel : NSObject

/** 商品ID */
@property(nonatomic, copy) NSString *objid;

/** 图片地址 */
@property(nonatomic, strong) NSArray<NSString *> *logo;

@end
