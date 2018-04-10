//
//  HEBOrderListModel.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/19.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderListModel.h"

@implementation HEBOrderListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    //被替换的key可以是多个，使用数组代表多个@[@"123",@"456"]
    return @{@"name":@[@"name", @"coupon_name", @"title"],
             @"money":@[@"integral", @"price", @"point"]
             };
}

- (NSString *)statusStr {
    switch (_type) {
        case 1:
            return [self foodMsg];
            break;
        case 2:
            return [self moveMsg];
            break;
        case 3:
            return [self fallowMsg];
            break;
        case 4:
            return [self hotelMsg];
            break;
        case 5:
            return [self takOutMsg];
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)statusHidden {
    if (((_type == 1 || _type == 3 || _type == 4 || _type == 5) && (_status == 0 || _status == 6)) ||
        (_type == 2 && _status == 5)) {
            return YES;
    }
    return NO;
}

- (BOOL)statusEnabled {
    if (((_type == 1 || _type == 3 || _type == 4 || _type == 5) && (_status == 2 || _status == 3)) ||
        (_type == 2 && _status == 2)) {
        return NO;
    }
    return YES;
}

- (NSString *)foodMsg {
    switch (_status) {
        case 0:
            return @"已取消";
            break;
        case 1:
            return @"付款";
            break;
        case 2:
            return @"已付款";
            break;
        case 3:
            return @"配送中";
            break;
        case 5:
            return @"去评价";
            break;
        case 6:
            return @"已评价";
            break;
        case 11:
            return @"已接单";
            break;
        case 99:
            return @"取消达达订单";
            break;
        default:
            break;
    }
    return @"";
}

- (NSString *)moveMsg {
    switch (_status) {
        case 0:
            return @"已取消";
            break;
        case 1:
            return @"付款";
            break;
        case 2:
            return @"已付款";
            break;
        case 3:
            return @"确认";
            break;
        case 5:
            return @"已完成";
            break;
        default:
            break;
    }
    return @"";
}

- (NSString *)fallowMsg {
    return [self foodMsg];
}

- (NSString *)hotelMsg {
    return [self foodMsg];
}

- (NSString *)takOutMsg {
    return [self foodMsg];
}

@end
