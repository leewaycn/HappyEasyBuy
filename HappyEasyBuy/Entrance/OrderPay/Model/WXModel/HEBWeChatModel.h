//
//  HEBWeChatModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/2.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBWeChatModel : NSObject

/** 商家根据微信开放平台文档对数据做的签名 */
@property(nonatomic, copy) NSString *sign;

/** 商家向财付通申请的商家id */
@property(nonatomic, copy) NSString *partnerid;

/** 商家根据财付通文档填写的数据和签名 */
@property(nonatomic, copy) NSString *package;

/** 随机串，防重发 */
@property(nonatomic, copy) NSString *noncestr;

/** 时间戳，防重发 */
@property(nonatomic, assign) UInt32 timestamp;

/** appid */
@property(nonatomic, copy) NSString *appid;

/** 预支付订单 */
@property(nonatomic, copy) NSString *prepayid;

@end
