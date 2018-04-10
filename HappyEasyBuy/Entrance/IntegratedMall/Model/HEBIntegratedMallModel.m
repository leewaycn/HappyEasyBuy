//
//  HEBIntegratedMallModel.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBIntegratedMallModel.h"

@implementation HEBIntegratedMallModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"objid":@[@"coupon_id", @"id"],
             @"title":@[@"coupon_name", @"title"],
             @"pic":@[@"goods_pic", @"coupon_pic"],
             @"integral":@[@"integral", @"coupon_integral"],
             };
}

@end
