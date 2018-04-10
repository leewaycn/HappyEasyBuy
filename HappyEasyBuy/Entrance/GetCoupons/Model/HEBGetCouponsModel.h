//
//  HEBGetCouponsModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBGetCouponsModel : NSObject

/** 优惠券id */
@property(nonatomic, copy) NSString *objid;

/** 1充值卡；2代金券；3优惠券 */
@property(nonatomic, assign) int type;

/** 商铺id */
@property(nonatomic, copy) NSString *vipid;

/** 优惠券金额 */
@property(nonatomic, copy) NSString *money;

/** 优惠券序列号 */
@property(nonatomic, copy) NSString *cardno;

/** 优惠卡密 */
@property(nonatomic, copy) NSString *cardpwd;

/** 状态  0：生成，1：已建卡，2：已使用(没用） */
@property(nonatomic, assign) int status;

/** 开始时间 */
@property(nonatomic, copy) NSString *stime;

/** 结束时间 */
@property(nonatomic, copy) NSString *etime;

/** 满多少可用 */
@property(nonatomic, copy) NSString *usemoney;

/** 优惠券添加时间 */
@property(nonatomic, copy) NSString *ctime;

@end
