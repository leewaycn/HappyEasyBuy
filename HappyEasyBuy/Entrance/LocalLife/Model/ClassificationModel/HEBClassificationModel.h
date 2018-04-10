//
//  HEBClassificationModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/15.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBClassificationModel : NSObject

/** 店铺ID */
@property(nonatomic, copy) NSString *objid;

/** 图片地址 */
@property(nonatomic, copy) NSString *icon;

/** 排名 */
@property(nonatomic, copy) NSString *sorts;

/** 名称 */
@property(nonatomic, copy) NSString *name;

@end
