//
//  HEBOrderFoodDetailModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HEBOrderFoodDetailPackModel;

@interface HEBOrderFoodDetailModel : NSObject

/** 套餐图片 */
@property(nonatomic, copy) NSString *f_pic;

/** 套餐名称 */
@property(nonatomic, copy) NSString *f_name;

/** 套餐简介 */
@property(nonatomic, copy) NSString *f_name_account;

/** 实际价格 */
@property(nonatomic, copy) NSString *f_price;

/** 门市价格 */
@property(nonatomic, copy) NSString *f_oprice;

/** 核销码 */
@property(nonatomic, copy) NSString *order_code;

/** 订单编号 */
@property(nonatomic, copy) NSString *order_number;

/** 收货人手机号 */
@property(nonatomic, copy) NSString *order_tel;

/** 下单时间 */
@property(nonatomic, copy) NSString *order_time;

/** 购买数量 */
@property(nonatomic, copy) NSString *order_num;

/** 订单总价 */
@property(nonatomic, copy) NSString *order_price;

/** 实付价格 */
@property(nonatomic, copy) NSString *order_payprice;

/** 套餐ID */
@property(nonatomic, copy) NSString *f_id;

/** 状态  1：未付款2：已付款3:已核销6：已评论 4：支付超时 */
@property(nonatomic, assign) int order_status;

/** 店铺名称 */
@property(nonatomic, copy) NSString *name;

/** 店铺地址 */
@property(nonatomic, copy) NSString *address;

/** 商家电话 */
@property(nonatomic, copy) NSString *phone;

/** 套餐详情 */
@property(nonatomic, strong) NSArray<HEBOrderFoodDetailPackModel *> *group;

/** 经度 */
@property(nonatomic, copy) NSString *lat;

/** 纬度 */
@property(nonatomic, copy) NSString *lng;

/** 状态字符 */
@property(nonatomic, copy) NSString *order_statusStr;

/** 电影名称 */
@property(nonatomic, copy) NSString *mname;

@end

@interface HEBOrderFoodDetailPackModel : NSObject

/** 商品名称 */
@property(nonatomic, copy) NSString *t_name;

/** 数量 */
@property(nonatomic, copy) NSString *t_num;

/** 价格 */
@property(nonatomic, copy) NSString *t_price;

@end
