//
//  HEBOrderIntegratedDetailModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBOrderIntegratedDetailModel : NSObject

/** /状态 */
@property(nonatomic, copy) NSString *status;

/** 快递单号 */
@property(nonatomic, copy) NSString *ex_odd;

/** 快递名称 */
@property(nonatomic, copy) NSString *ex_name;

/** 发货时间 */
@property(nonatomic, copy) NSString *shiptime;

/** 收货时间 */
@property(nonatomic, copy) NSString *receivingtime;

/** 兑换时间 */
@property(nonatomic, copy) NSString *buytime;

/** 手机号码 */
@property(nonatomic, copy) NSString *phone;

/** 地址 */
@property(nonatomic, copy) NSString *address;

/** 姓名 */
@property(nonatomic, copy) NSString *name;

/** 商品描述 */
@property(nonatomic, copy) NSString *title;

/** 换商品消耗积分 */
@property(nonatomic, copy) NSString *integral;

/** 图片 */
@property(nonatomic, copy) NSString *pic;

@end
