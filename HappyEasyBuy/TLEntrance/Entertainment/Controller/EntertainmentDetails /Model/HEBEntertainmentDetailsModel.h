//
//  HEBEntertainmentDetailsModel.h
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/11.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBEntertainmentDetailsModel : NSObject
//"data": {
//    "ha_id": "4",//店铺ID
//    "ha_name": "艳遇养生足道",//店铺名称
//    "ha_address": "河东区人民大街与滨河大道交汇处东100米",
//    "ha_tel": "0539-7456321",//联系手机号
//    "lng": "118.411416",//当前经度
//    "lat": "35.090240",//当前纬度
//    "ha_banner": "446,445",
//    "imgurl": [
//               "http://luntan.guoxiangou.cn/upload/img/2017-09-22/59c4dc7341c58.jpg",
//               "http://luntan.guoxiangou.cn/upload/img/2017-09-22/59c4dc923df4f.jpg"
//               ],//店铺详情图片
//    "distance": "7.5km"//距离
//}
//店铺ID
@property(nonatomic, copy)NSString *ha_id;
//店铺名称
@property(nonatomic, copy)NSString *ha_name;
//地址
@property(nonatomic, copy)NSString *ha_address;
//联系手机
@property(nonatomic, copy)NSString *ha_tel;
//当前经维度
@property(nonatomic, assign)double *lng;
//当前纬度
@property(nonatomic, assign)double *lat;

@property(nonatomic, copy)NSString *ha_banner;
//店铺详情图片
@property(nonatomic, strong)NSString *imgurl;
//距离
@property(nonatomic, copy)NSString *distance;


@end
