//
//  HEBTakOutOrderDetailModel.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/15.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutOrderDetailModel.h"

@implementation HEBTakOutOrderDetailModel

@end


@implementation HEBTakOutOrderUseINFOModel

+ (NSDictionary *)modelCustomPropertyMapper {
    //被替换的key可以是多个，使用数组代表多个@[@"123",@"456"]
    return @{@"objid":@"id"};
}

@end

@implementation HEBTakOutOrderShopINFOModel

- (NSString *)send_status {
    if ([_send_status isEqualToString:@"1"]) {
        return @"商家自送";
    }
    return @"达达快递";
}

@end
