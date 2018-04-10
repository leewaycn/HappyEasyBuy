//
//  HEBroomCommentModel.h
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/2.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBRoomCommentModel : NSObject
//            {
//                id = 11;
//                reply_cont = ;
//                reply_time = 1970-01-01 08:00:00;
//                name = 小手冰凉;
//                time = 2017-11-28 15:32:39;
//                order_id = H2017112809532393057;
//                shopid = 1;
//                type = 4;
//                headimg = http://luntan.guoxiangou.cn/Upload/photo/2017-12-29/20171229181554.jpg;
//                vipid = 3;
//                icon = (
//                );
//                goodsid = 0;
//                score = 5;
//                status = 0;
//                content = 这个大床房，第二次来了，哈哈;
//            }
//            {
//                id = 5;
//                reply_cont = 您的肯定是对我们最大的支持！！！;
//                reply_time = 2017-11-28 11:46:19;
//                name = <null>;
//                time = 2017-11-28 10:19                               time = 2017-11-28 10:19
//用户ID
@property(nonatomic, copy)NSString *objid;
//回答内容
@property(nonatomic, copy)NSString *reply_cont;
//回答时间
@property(nonatomic, copy)NSString *reply_time;
//用户名称
@property(nonatomic, copy)NSString *name;
//评论日期
@property(nonatomic, copy)NSString *time;
//订单号
@property(nonatomic, copy)NSString *order_id;
//
@property(nonatomic, copy)NSString *shopid;
//
@property(nonatomic, copy)NSString *type;
//头像
@property(nonatomic, copy)NSString *headimg;
//
@property(nonatomic, copy)NSString *vipid;
//评论图片
@property(nonatomic, copy)NSString *icon;
//
@property(nonatomic, copy)NSString *goodsid;
//星评
@property(nonatomic, copy)NSString *score;
//状态 判断是否有商家回复 1有回复，0无回复
@property(nonatomic, copy)NSString *status;
//用户评论内容
@property(nonatomic, copy)NSString *content;

@end
