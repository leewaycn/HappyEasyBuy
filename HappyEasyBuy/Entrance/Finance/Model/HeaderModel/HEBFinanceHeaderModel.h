//
//  HEBFinanceHeaderModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBFinanceHeaderModel : NSObject

/** 用户余额 */
@property(nonatomic, copy) NSString *money;

/** 用户余额宝余额 */
@property(nonatomic, copy) NSString *m_money;

/** 昨日收益 */
@property(nonatomic, copy) NSString *daily_yes;

/** 固定产品总收益 */
@property(nonatomic, copy) NSString *daily;

@end
