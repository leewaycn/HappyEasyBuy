//
//  HEBCityModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/27.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HEBCityModel;

@interface HEBPCAModel : NSObject

/** 省 */
@property(nonatomic, copy) NSString *name;

/** 市 */
@property(nonatomic, strong) NSArray<HEBCityModel *> *city;

@end

@interface HEBCityModel : NSObject

/** 城市名 */
@property(nonatomic, copy) NSString *name;

/** 县/区 */
@property(nonatomic, copy) NSArray<NSString *> *area;

@end
