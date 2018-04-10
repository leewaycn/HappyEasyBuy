//
//  HEBIntegratedMallGoodsDetailModel.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBIntegratedMallGoodsDetailModel.h"

@implementation HEBIntegratedMallGoodsDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goods_id":@[@"goods_id", @"type_id"],
             @"name":@[@"coupon_name", @"title"],
             @"integral":@[@"point", @"integral"],
             @"goods_pic":@[@"coupon_pic", @"goods_pic"]
             };
}

@end
