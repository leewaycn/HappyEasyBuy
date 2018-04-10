//
//  HEBFinanceModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBFinanceModel : NSObject

/** 产品名称 */
@property(nonatomic, copy) NSString *f_name;

/** 百分比 */
@property(nonatomic, copy) NSString *f_rate;

/** 产品id */
@property(nonatomic, copy) NSString *f_id;

/** 产品二级描述 */
@property(nonatomic, copy) NSString *f_desc1;

/** 产品一级描述 */
@property(nonatomic, copy) NSString *f_desc;

/** 二级百分比 */
@property(nonatomic, copy) NSString *f_rate1;

@end
