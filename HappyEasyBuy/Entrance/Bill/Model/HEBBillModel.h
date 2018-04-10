//
//  HEBBillModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/9.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBBillModel : NSObject

/** 金融收益类型（0：日收益；1：固定收益定期产品；2：固定收益分期产品;3:固定收益20%分期产品）  */
@property(nonatomic, copy) NSString *r_type;

/** 创建账单时间 */
@property(nonatomic, copy) NSString *ctime;

/** 产品名称 */
@property(nonatomic, copy) NSString *f_name;

/** 账单ID */
@property(nonatomic, copy) NSString *objid;

/** 用户id */
@property(nonatomic, copy) NSString *u_id;

@end
