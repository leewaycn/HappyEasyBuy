//
//  HEBEntertainmentDetailsListModel.h
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBEntertainmentDetailsListModel : NSObject

/** 封面图片 */
@property(nonatomic, copy) NSString *imgurl;

/** 已售 */
@property(nonatomic, copy) NSString *f_sold;

/** 价格 */
@property(nonatomic, copy) NSString *f_pic;

/** 团购价 */
@property(nonatomic, copy) NSString *f_price;

/** 套餐ID */
@property(nonatomic, copy) NSString *f_id;

/** 套餐名称 */
@property(nonatomic, copy) NSString *f_name;

@end
