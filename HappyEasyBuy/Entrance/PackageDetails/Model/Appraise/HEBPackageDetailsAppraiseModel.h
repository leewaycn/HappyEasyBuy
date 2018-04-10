//
//  HEBAppraiseModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBPackageDetailsAppraiseModel : NSObject

/** 评论id */
@property(nonatomic, copy) NSString *objid;

/** 用户id */
@property(nonatomic, copy) NSString *vipid;

/** 订单id */
@property(nonatomic, copy) NSString *order_id;

/** 评分 */
@property(nonatomic, assign) float score;

/** 评论内容 */
@property(nonatomic, copy) NSString *content;

/** 评论时间 */
@property(nonatomic, copy) NSString *time;

/** 回复内容 */
@property(nonatomic, copy) NSString *reply_cont;

/** 恢复时间 */
@property(nonatomic, copy) NSString *reply_time;

/** 商家是否恢复（1：回复 0：未回复） */
@property(nonatomic, assign) BOOL status;

/** 商家id */
@property(nonatomic, copy) NSString *shopid;

/** 商家店铺类型 */
@property(nonatomic, assign) int type;

/** 评论用户名 */
@property(nonatomic, copy) NSString *name;

/** 评论用户头像  */
@property(nonatomic, copy) NSString *headimg;

/** 评论图片 */
@property(nonatomic, strong) NSArray<NSString *> *icon;

/** 商家图片 */
@property(nonatomic, strong) NSArray<NSString *> *shop_logo;

/** 商家名称 */
@property(nonatomic, copy) NSString *shop_name;

@end
