//
//  HEBOrderHotelDetailModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBOrderHotelDetailModel : NSObject

/** 酒店名 */
@property(nonatomic, copy) NSString *h_name;

/** 地址 */
@property(nonatomic, copy) NSString *h_address;

/** 房间名 */
@property(nonatomic, copy) NSString *r_name;

/** 入驻时间 */
@property(nonatomic, copy) NSString *order_cometime;

/** 离开时间 */
@property(nonatomic, copy) NSString *order_leavetime;

/** 共计几晚 */
@property(nonatomic, copy) NSString *order_num;

/** 住店人名称 */
@property(nonatomic, copy) NSString *order_name;

/** 预留手机号 */
@property(nonatomic, copy) NSString *order_tel;

/** 订单价格 */
@property(nonatomic, copy) NSString *order_price;

/** 订单编号 */
@property(nonatomic, copy) NSString *order_number;

/** 下单时间 */
@property(nonatomic, copy) NSString *order_time;

/** 预计到店时间 */
@property(nonatomic, copy) NSString *order_arrtime;

/** 介绍 */
@property(nonatomic, copy) NSString *info;

/** 订单状态 */
@property(nonatomic, assign) int order_status;

/** 酒店电话 */
@property(nonatomic, copy) NSString *h_tel;

/** 酒店ID */
@property(nonatomic, copy) NSString *h_id;

/** 核销码 */
@property(nonatomic, copy) NSString *order_code;

/** 经度 */
@property(nonatomic, copy) NSString *lat;

/** 纬度 */
@property(nonatomic, copy) NSString *lng;

/** 状态字符 */
@property(nonatomic, copy) NSString *order_statusStr;

@end
