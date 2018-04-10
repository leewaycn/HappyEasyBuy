//
//  MainModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject

/** 反馈内容 */
@property(nonatomic, copy) NSString *msg;

/** 具体内容 */
@property(nonatomic, assign) id data;

/** 是否请求成功 */
@property(nonatomic, assign) BOOL status;

@end
