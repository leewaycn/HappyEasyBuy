//
//  HEBLocationModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/26.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBLocationModel : NSObject

/** 地址id */
@property(nonatomic, copy) NSString *locationid;

/** 收货人姓名 */
@property(nonatomic, copy) NSString *name;

/** 用户id */
@property(nonatomic, copy) NSString *vipid;

/** 电话 */
@property(nonatomic, copy) NSString *mobile;

/** 地址 */
@property(nonatomic, copy) NSString *location;

/** 详细地址 */
@property(nonatomic, copy) NSString *address;

/** 0:男， 1:女 */
@property(nonatomic, assign) BOOL call;

@end
