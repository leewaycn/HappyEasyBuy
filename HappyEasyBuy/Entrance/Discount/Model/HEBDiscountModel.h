//
//  HEBDiscountModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBDiscountModel : NSObject

/** 开始时间 */
@property(nonatomic, copy) NSString *stime;

/** 结束时间 */
@property(nonatomic, copy) NSString *etime;

/** 描述 */
@property(nonatomic, copy) NSString *yh_des;

/** 减掉的钱 */
@property(nonatomic, copy) NSString *money;

/** 店铺 */
@property(nonatomic, copy) NSString *shop_name;

@end
