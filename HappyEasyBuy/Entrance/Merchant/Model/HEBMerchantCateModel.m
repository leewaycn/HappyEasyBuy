//
//  HEBMerchantCateModel.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/2.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBMerchantCateModel.h"

@implementation HEBMerchantCateModel

+ (NSDictionary *)modelCustomPropertyMapper {
    //被替换的key可以是多个，使用数组代表多个@[@"123",@"456"]
    return @{@"cateid":@"id"};
}

@end
