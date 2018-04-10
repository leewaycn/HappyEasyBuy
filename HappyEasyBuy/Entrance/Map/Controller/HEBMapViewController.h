//
//  HEBMapViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/25.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBMapViewController : HEBBaseViewController

/** 店铺纬度 */
@property(nonatomic, assign) double lat;

/** 店铺经度 */
@property(nonatomic, assign) double lon;

/** 店铺名称 */
@property(nonatomic, copy) NSString *shopName;

/** 地址 */
@property(nonatomic, copy) NSString *address;

/** 联系方式 */
@property(nonatomic, copy) NSString *phone;

@end
