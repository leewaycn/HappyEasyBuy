//
//  HEBHappyMoneyTopUpModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBHappyMoneyTopUpModel : NSObject

/** 到账数量 */
@property(nonatomic, copy) NSString *c_reduce;

/** 充值金额 */
@property(nonatomic, copy) NSString *c_full;

/** 金额id */
@property(nonatomic, copy) NSString *c_id;

@end
