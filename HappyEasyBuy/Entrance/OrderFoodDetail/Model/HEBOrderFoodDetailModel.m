//
//  HEBOrderFoodDetailModel.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderFoodDetailModel.h"

@implementation HEBOrderFoodDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    //被替换的key可以是多个，使用数组代表多个@[@"123",@"456"]
    return @{@"name":@[@"ha_name", @"name"],
             @"address":@[@"address", @"ha_address"],
             @"phone":@[@"ha_tel", @"phone", @"mphone"],
             @"order_number":@[@"oid", @"order_number"],
             @"order_num":@[@"order_num", @"num"],
             @"order_code":@[@"code", @"order_code"],
             @"f_name_account":@[@"f_name_account", @"date"],
             @"f_oprice":@[@"f_oprice", @"c_price"],
             @"f_pic":@[@"m_pic", @"f_pic"],
             @"order_time":@[@"ctime", @"order_time"],
             @"order_tel":@[@"phone", @"order_tel"],
             @"order_price":@[@"total_price", @"order_price"],
             @"f_price":@[@"f_price", @"c_price"]
             };
}

- (NSString *)order_statusStr {
    switch (_order_status) {
        case 1:
            return @"未付款";
            break;
        case 2:
            return @"已付款";
            break;
        case 3:
            return @"已核销";
            break;
        case 4:
            return @"支付超时";
            break;
        case 6:
            return @"已评论";
            break;
        case 0:
            return @"已取消";
            break;
        default:
            break;
    }
    return @"";
}

@end

@implementation HEBOrderFoodDetailPackModel

@end
