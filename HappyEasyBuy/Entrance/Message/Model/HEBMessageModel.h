//
//  HEBMessageModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/8.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBMessageModel : NSObject

/** 通知ID */
@property(nonatomic, copy) NSString *objid;

/** 标题 */
@property(nonatomic, copy) NSString *title;

/** 详情 */
@property(nonatomic, copy) NSString *content;

/** 时间 */
@property(nonatomic, copy) NSString *ctime;

@end
