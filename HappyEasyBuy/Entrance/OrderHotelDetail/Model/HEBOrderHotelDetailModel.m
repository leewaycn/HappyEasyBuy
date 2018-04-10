//
//  HEBOrderHotelDetailModel.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderHotelDetailModel.h"

@implementation HEBOrderHotelDetailModel

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
