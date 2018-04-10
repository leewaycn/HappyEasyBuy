//
//  HEBGroupBuyDetailsModel.h
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/11.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HEBPackagesModel;
@interface HEBGroupBuyDetailsModel : NSObject
//data = {
//    shop_id = 1;
//    ha_address = 山东省临沂市罗庄区;
//    f_cue = 怡情慎行  不要贪杯;
//    f_name = 套餐测试;
//    f_endtime = 2017-11-28;
//    imgurl = (
//              http://luntan.guoxiangou.cn/upload/img/2017-11-27/5a1bcdcbd9171.png,
//              );
//    f_name_account = 套餐娱乐;
//    f_starttime1 = 21:00;
//    f_sold = 0;
//    f_id = 1;
//    f_bespeak = 嘿嘿嘿嘿;
//    f_oprice = 658.00;
//    f_seller = 123;
//    f_banner = 84;
//    distance = 12563.5km;
//    packages = (
//                {
//                    foot_desc = 嘿嘿嘿;
//                    foot_name = 大保健;
//                    foot_num = 1;
//                    foot_id = 3;
//                    foot_namedesc = 羞羞的大保健;
//                    foot_price = 298;
//                }
//                ,
//                {
//                    foot_desc = 黑恶;
//                    foot_name = 小保健;
//                    foot_num = 2;
//                    foot_id = 4;
//                    foot_namedesc = 羞羞的小保健;
//                    foot_price = 360;
//                }
//                ,
//                );
//    f_rule = 怡情慎行;
//    ha_name = 测试休闲店铺;
//    f_starttime = 2017-11-26;
//    f_endtime1 = 02:00;
//    ha_tel = 17853913976;
//    f_price = 600.00;
//    f_apply = 青壮年;
//}
//店铺ID
@property(nonatomic, copy)NSString *shop_id;
//店铺地址
@property(nonatomic, copy)NSString *ha_address;
//温馨提示
@property(nonatomic, copy)NSString *f_cue;
//套餐名称
@property(nonatomic, copy)NSString *f_name;
//有效期结束时间
@property(nonatomic, copy)NSString *f_endtime;
//套餐详情图片
@property(nonatomic, strong)NSArray *imgurl;
//名称简介
@property(nonatomic, copy)NSString *f_name_account;
//使用开始时间
@property(nonatomic, copy)NSString *f_starttime1;
//已售
@property(nonatomic, copy)NSString *f_sold;
//套餐ID
@property(nonatomic, copy)NSString *f_id;
//预约信息
@property(nonatomic, copy)NSString *f_bespeak;
//总价
@property(nonatomic, copy)NSString *f_oprice;
//商家服务
@property(nonatomic, copy)NSString *f_seller;

@property(nonatomic, copy)NSString *f_banner;
//距离
@property(nonatomic, copy)NSString *distance;


//packages套餐信息模型数组
@property(nonatomic, strong)NSMutableArray *packages;


//规则提醒
@property(nonatomic, copy)NSString *f_rule;
//店铺名称
@property(nonatomic, copy)NSString *ha_name;
//有效期开始时间
@property(nonatomic, copy)NSString *f_starttime;
//使用结束时间
@property(nonatomic, copy)NSString *f_endtime1;
//联系电话
@property(nonatomic, copy)NSString *ha_tel;
//团购价
@property(nonatomic, copy)NSString *f_price;
//适用人数
@property(nonatomic, copy)NSString *f_apply;



@end
