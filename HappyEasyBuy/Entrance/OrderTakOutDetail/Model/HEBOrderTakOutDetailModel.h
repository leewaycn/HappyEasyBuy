//
//  HEBOrderTakOutDetailModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HEBTakOutBuyCarModel.h"

@interface HEBOrderTakOutDetailModel : NSObject

/** 订单编号 */
@property(nonatomic, copy) NSString *oid;

/** 下单时间 */
@property(nonatomic, copy) NSString *ctime;

/** 购买产品列表 */
@property(nonatomic, strong) NSArray<HEBTakOutBuyCarModel *> *items;

/** 配送费 */
@property(nonatomic, copy) NSString *psprice;

/** 状态0：已取消  1：未付款  2：已付款  11：已接单 3：配送中  5：已完成  6:已评价  99：取消达达订单 */
@property(nonatomic, assign) int status;

/** 下单人姓名 */
@property(nonatomic, copy) NSString *vipname;

/** 手机号 */
@property(nonatomic, copy) NSString *vipmobile;

/** 地址 */
@property(nonatomic, copy) NSString *vipaddress;

/** 配送方式   1：商家自送，2：达达派送，0：空 */
@property(nonatomic, copy) NSString *psway;

/** 备注信息 */
@property(nonatomic, copy) NSString *msg;

/** 总价 */
@property(nonatomic, copy) NSString *totalprice;

/** 商家电话 */
@property(nonatomic, copy) NSString *sphone;

/** 剩余秒数  0就是取消订单了 */
@property(nonatomic, copy) NSString *sytime;

/** 店铺名 */
@property(nonatomic, copy) NSString *name;

/** 商家图片 */
@property(nonatomic, copy) NSString *pic;

/** 状态字符 */
@property(nonatomic, copy) NSString *order_statusStr;

@end


