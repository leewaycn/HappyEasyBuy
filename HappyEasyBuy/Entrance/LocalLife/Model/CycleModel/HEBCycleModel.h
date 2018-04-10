//
//  HEBCycleModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBCycleModel : NSObject

/** 简介 */
@property(nonatomic, copy) NSString *summary;

/** 未知 */
@property(nonatomic, copy) NSString *module;

/** 商铺名称 */
@property(nonatomic, copy) NSString *shopname;

/** id */
@property(nonatomic, copy) NSString *objid;

/** 图片地址 */
@property(nonatomic, copy) NSString *pic;

/** 类型 */
@property(nonatomic, copy) NSString *type;

/** 名称 */
@property(nonatomic, copy) NSString *name;

/** 跳转地址 */
@property(nonatomic, copy) NSString *url;

@end
