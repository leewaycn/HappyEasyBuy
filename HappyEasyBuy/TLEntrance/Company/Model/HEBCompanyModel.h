//
//  HEBCompanyModel.h
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/4.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBCompanyModel : NSObject
//data = (
//        {
//            address = 山东省临沂市罗庄区龙湖软件园;
//            id = 1;
//            hotline = 7417417474741;
//            name = 百度;
//            logo = http://luntan.guoxiangou.cn/Upload/img/2017-12-11/5a2e3ea5175df.png;
//        }
//公司地址
@property(nonatomic, copy)NSString *address;
//公司id
@property(nonatomic, copy)NSString *objid;
//公司名称
@property(nonatomic, copy)NSString *name;
//公司logo
@property(nonatomic, copy)NSString *logo;


@end
