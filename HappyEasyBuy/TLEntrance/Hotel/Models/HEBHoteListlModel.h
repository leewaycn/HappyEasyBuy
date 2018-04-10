//
//  HEBHotelModel.h
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBHoteListlModel : NSObject
//酒店id
@property (nonatomic,copy)NSString *h_id;
//酒店名称
@property (nonatomic,copy)NSString *h_name;
//酒店头像图片
@property (nonatomic,copy)NSString *h_pic;
//地区
@property (nonatomic,copy)NSString *h_address;
//经度
@property (nonatomic,copy)NSString *lng;
//纬度
@property (nonatomic,copy)NSString *lat;
//价格
@property (nonatomic,copy)NSString *h_price;
//距离 +km
@property (nonatomic,copy)NSString *distance;
//距离
@property (nonatomic,copy)NSString *distances;
//星分数
@property (nonatomic,copy)NSString *score;

@end
