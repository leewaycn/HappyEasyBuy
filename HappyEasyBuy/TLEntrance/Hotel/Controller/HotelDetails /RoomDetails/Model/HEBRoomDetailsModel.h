//
//  HEBRoomDetailsModel.h
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/2.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBRoomDetailsModel : NSObject
//[打印内容:{
//    msg = 查询房间详情成功;
//    data = {
//        r_internet = 0;
//        r_name = 豪华双床房;
//        r_price = 249.00;
//        r_acreage = 20;
//        r_breakfast = 0;
//        imgurl = (
//                  http://luntan.guoxiangou.cn/upload/img/2017-11-28/5a1cbd97cdb68.png,
//                  );
//        r_banner = 94;
//        r_window = 0;
//        r_number = 2;
//        r_rule = 直接消费，无需排队，请携带入住身份证;
//        r_floor = 5;
//        r_bed = 大床,1.8*2.0米米,1张;
//        r_id = 3;
//        r_bathroom = 0;
//    }
////上网方式0：wifi1：无
@property(nonatomic, assign)NSInteger r_internet;
//房间名
@property(nonatomic, copy)NSString *r_name;
//价格
@property(nonatomic, assign)NSString *r_price;
////面积大小（㎡）
@property(nonatomic, assign)NSInteger *r_acreage;
//早餐0：有早餐，1：不含早
@property(nonatomic, assign)NSInteger r_breakfast;
//房间详情图片
@property(nonatomic, strong)NSString *imgurl;
// "r_banner": "435,434",//图片ID
@property(nonatomic, copy)NSString *r_banner;
//窗户0：有窗，1：没窗户
@property(nonatomic, assign)NSInteger r_window;
//    "r_number": "1",//可住人数
@property(nonatomic, copy)NSString *r_number;
//使用规则
@property(nonatomic, copy)NSString *r_rule;
// "r_floor": "4-7",//楼层
@property(nonatomic, assign)NSInteger *r_floor;
//床型
@property(nonatomic, copy)NSString *r_bed;
//房间id
@property(nonatomic, copy)NSString *r_id;
//卫浴 "r_bathroom": "1",//卫浴0：独立，1：不独立
@property(nonatomic, assign)NSInteger r_bathroom;


@end
