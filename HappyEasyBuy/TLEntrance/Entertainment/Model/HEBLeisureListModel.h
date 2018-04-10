//
//  HEBLeisureModel.h
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/27.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBLeisureListModel : NSObject
//{
//    msg = 查询足疗列表成功;
//    data = (
//            {
//                ha_pic = 81;
//                imgurl = http://luntan.guoxiangou.cn/Upload/img/2017-11-27/5a1bcca4ba1c8.png;
//                distance = 7.2km;
//                minprice = 0.01;
//                score = 4;
//                ha_name = 测试休闲店铺;
//                lng = 118.297279;
//                ha_id = 1;
//                lat = 34.964343;
//            }

@property(copy, nonatomic)NSString *ha_pic;
//封面图片
@property(copy, nonatomic)NSString *imgurl;
//距离
@property(copy, nonatomic)NSString *distance;
//评分
@property(assign, nonatomic)NSInteger *score;
//店铺名称
@property(copy, nonatomic)NSString *ha_name;
//经度
@property(copy, nonatomic)NSString *lng;
//纬度
@property(copy, nonatomic)NSString *lat;
//店铺ID
@property(copy, nonatomic)NSString *ha_id;

@end
