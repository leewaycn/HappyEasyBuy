//
//  HEBOrderListModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/19.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBOrderListModel : NSObject

/** 套餐名称 */
@property(nonatomic, copy) NSString *name;

/** ID号 */
@property(nonatomic, copy) NSString *oid;

/** 订单状态0：已取消  1：未付款  2：已付款  11：已接单 3：配送中  5：已完成  6:已评价  99：取消达达订单 */
@property(nonatomic, assign) int status;

/** 数量 */
@property(nonatomic, copy) NSString *num;

/** 店铺封面 */
@property(nonatomic, copy) NSString *pic;

/** 订单创建时间 */
@property(nonatomic, copy) NSString *ctime;

/** 订单号 */
@property(nonatomic, copy) NSString *ordernumber;

/** 店铺ID */
@property(nonatomic, copy) NSString *shopid;

/** 金额/积分 */
@property(nonatomic, copy) NSString *money;

/** 订单状态对应字符串 */
@property(nonatomic, copy) NSString *statusStr;

/** 店铺类型  1:美食 2：电影 3：休闲娱乐 4:酒店 5：外卖 6：服饰 7：公司企业 */
@property(nonatomic, assign) int type;

/** 是否隐藏状态显示 */
@property(nonatomic, assign) BOOL statusHidden;

/** 状态是否可操作 */
@property(nonatomic, assign) BOOL statusEnabled;

/** 积分订单号 */
@property(nonatomic, copy) NSString *order;

@end
