//
//  HEBOrderIntegratedDetailModel.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderIntegratedDetailModel.h"

@implementation HEBOrderIntegratedDetailModel

- (NSString *)status {
    if ([_status isEqualToString:@"1"]) {
        return @"已发货";
    }else if ([_status isEqualToString:@"2"]) {
        return @"已签收";
    }
    return @"未发货";
}

@end
