//
//  HEBAppraiseModel.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBPackageDetailsAppraiseModel.h"

@implementation HEBPackageDetailsAppraiseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"objid":@"id",
             @"headimg":@[@"headimgurl", @"headimg"]
             };
}

@end
