//
//  HEBTakOutShopINFOModel.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutShopActiveINFOModel.h"

@implementation HEBTakOutShopActiveINFOModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ship_id":@"id"};
}

- (NSString *)send_status {
    if ([_send_status isEqualToString:@"1"]) {
        return @"商家自送";
    }
    return @"达达快递";
}

@end
