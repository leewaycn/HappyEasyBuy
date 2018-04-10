//
//  HEBOrderTakOutDetailModel.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderTakOutDetailModel.h"

@implementation HEBOrderTakOutDetailModel

- (NSString *)order_statusStr {
    switch (_status) {
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

- (NSString *)psway {
    if ([_psway isEqualToString:@"1"]) {
        return @"商家自送";
    }else if ([_psway isEqualToString:@"2"]) {
        return @"达达派送";
    }
    return @"";
}

@end
