//
//  HEBBalanceRecordModel.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/11.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBBalanceRecordModel.h"

@implementation HEBBalanceRecordModel

- (NSString *)payway {
    if ([_payway isEqualToString:@"alipay"]) {
        return @"支付宝支付";
    }
    return @"微信支付";
}

@end
