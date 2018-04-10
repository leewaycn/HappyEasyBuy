//
//  HEBLocationModel.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/26.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBLocationModel.h"

@implementation HEBLocationModel

+ (NSDictionary *)modelCustomPropertyMapper {
    //被替换的key可以是多个，使用数组代表多个@[@"123",@"456"]
    return @{@"locationid":@"id"};
}

@end
