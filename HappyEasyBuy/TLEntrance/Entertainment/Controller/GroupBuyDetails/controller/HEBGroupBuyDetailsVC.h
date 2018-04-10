//
//  HEBgroupBuyDetailsVC.h
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/1.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HEBGroupBuyDetailsModel;
@interface HEBGroupBuyDetailsVC : UIViewController
//套餐id
@property(nonatomic, copy)NSString *f_id;
//当前经度
@property(nonatomic, assign)double *lat;
//当前纬度
@property(nonatomic, assign)double *lng;
//套餐价格
@property(nonatomic, copy)NSString *f_pic;
//团购价
@property(nonatomic, copy)NSString *f_price;

@end
