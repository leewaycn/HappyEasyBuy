//
//  HEBAliPayModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/6.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBAliPayModel : NSObject

/** 返回码 */
@property(nonatomic, copy) NSString *resultStatus;

/** 具体原因 */
@property(nonatomic, copy) NSString *memo;

@end
