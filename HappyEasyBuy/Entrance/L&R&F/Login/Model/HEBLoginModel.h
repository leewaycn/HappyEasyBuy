//
//  HEBLoginModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBLoginModel : NSObject

/** 用户ID */
@property(nonatomic, copy) NSString *userid;

/** 昵称 */
@property(nonatomic, copy) NSString *nickname;

/** 头像 */
@property(nonatomic, copy) NSString *head_portrait;

/** 未知 */
@property(nonatomic, assign) BOOL is_shop;

@end
