//
//  HEBHotelDetailModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBHotelDetailModel : NSObject

/** 图片地址 */
@property(nonatomic, strong) NSArray<NSString *> *imgurl;

/** 酒店名称 */
@property(nonatomic, copy) NSString *h_name;

/** 地址 */
@property(nonatomic, copy) NSString *h_address;

/** 距离 */
@property(nonatomic, copy) NSString *distance;

/** 店铺经度 */
@property(nonatomic, copy) NSString *lng;

/** 店铺纬度 */
@property(nonatomic, copy) NSString *lat;

/** 电话 */
@property(nonatomic, copy) NSString *h_tel;

@end

