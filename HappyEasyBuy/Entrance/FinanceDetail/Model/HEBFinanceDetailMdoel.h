//
//  HEBFinanceDetailMdoel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBFinanceDetailMdoel : NSObject

/** 产品名称 */
@property(nonatomic, copy) NSString *f_name;

/** 利率 */
@property(nonatomic, copy) NSString *f_rate;

/** 产品id */
@property(nonatomic, copy) NSString *f_id;

/** 描述 */
@property(nonatomic, copy) NSString *f_desc;

/** 结束时间 */
@property(nonatomic, copy) NSString *f_endtime;

/** 产品类型 */
@property(nonatomic, copy) NSString *f_type;

/** 二级描述 */
@property(nonatomic, copy) NSString *f_desc2;

/** 三级描述 */
@property(nonatomic, copy) NSString *f_desc3;

@end
