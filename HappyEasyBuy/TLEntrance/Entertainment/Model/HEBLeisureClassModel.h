//
//  HEBLeisureClassModel.h
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/27.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//



//** 暂未使用此模型 */
//** 已使用 分类模型-->HEBClassificationModel */
#import <Foundation/Foundation.h>

@interface HEBLeisureClassModel : NSObject
//        {
//            id = 12;
//            name = 测试休闲2;
//            icon = http://luntan.guoxiangou.cn/Upload/img/2017-11-27/5a1b70fac15b5.png;
//        }
//店铺分类id
@property(copy, nonatomic)NSString *objid;
//店铺名称
@property(copy, nonatomic)NSString *name;
//店铺头像
@property(copy, nonatomic)NSString *icon;
@end
