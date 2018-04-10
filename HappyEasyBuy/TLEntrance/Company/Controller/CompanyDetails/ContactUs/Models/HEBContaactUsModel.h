//
//  HEBContaactUsModel.h
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/6.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBContaactUsModel : NSObject
//"id": "1",
//"hotline": "7417417474741",
//"contacts": "刘勇",
//"phone": "18515882970",
//"tel": "0539-201346",
//"email": "1095899414@qq.com",
//"address": "山东省临沂市罗庄区龙湖软件园"

//公司id
@property(nonatomic, copy)NSString *objid;
//咨询热线
@property(nonatomic, copy)NSString *hotline;
//联系人
@property(nonatomic, copy)NSString *contacts;
//手机
@property(nonatomic, copy)NSString *phone;
//电话
@property(nonatomic, copy)NSString *tel;
//邮箱
@property(nonatomic, copy)NSString *email;
//地址
@property(nonatomic, copy)NSString *address;

@end
