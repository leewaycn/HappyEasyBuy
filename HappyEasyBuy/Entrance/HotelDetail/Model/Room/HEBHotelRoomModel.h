//
//  HEBHotelRoomModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/25.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBHotelRoomModel : NSObject

/** 房间ID */
@property(nonatomic, copy) NSString *r_id;

/** 房间名称 */
@property(nonatomic, copy) NSString *r_name;

/** 价格 */
@property(nonatomic, copy) NSString *r_price;

/** 面积（m2） */
@property(nonatomic, copy) NSString *r_acreage;

/** 窗户0:有窗，1:没窗户  */
@property(nonatomic, assign) BOOL r_window;

/** 早餐0:有早餐，1:不含早  */
@property(nonatomic, assign) BOOL r_breakfast;

/** 床型 */
@property(nonatomic, copy) NSString *r_bed;

/** 大小床 */
@property(nonatomic, copy) NSString *r_bed1;

@end
