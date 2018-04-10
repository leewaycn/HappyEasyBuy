//
//  HEBProductlistModel.h
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/6.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBProductlistModel : NSObject
//"id": "2",
//"name": "公众号开发",
//"album": "http:\/\/luntan.guoxiangou.cn",
//"parameter": "满足您的基本需求",
//"purpose": "用于宣传和交流",
//"cid": "2",
//"ctime": "1512981166",
//"status": "1",
//"shopid": "1"

@property(nonatomic, copy)NSString *objid;
//产品名称
@property(nonatomic, copy)NSString *name;
//产品logo
@property(nonatomic, copy)NSString *album;
//参数
@property(nonatomic, copy)NSString *parameter;
//用途
@property(nonatomic, copy)NSString *purpose;
//
@property(nonatomic, copy)NSString *cid;
//
@property(nonatomic, copy)NSString *ctime;
//
@property(nonatomic, copy)NSString *status;
//
@property(nonatomic, copy)NSString *shopid;

@end
