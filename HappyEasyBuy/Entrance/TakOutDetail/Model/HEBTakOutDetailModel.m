//
//  HEBTakOutDetailModel.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/8.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutDetailModel.h"

@implementation HEBTakOutDetailModel
@end

@implementation HEBTakOutShopINFOModel
@end

@implementation HEBTakOutShopModel
+ (NSDictionary *)modelCustomPropertyMapper {
    //被替换的key可以是多个，使用数组代表多个@[@"123",@"456"]
    return @{@"food_id":@"id"};
}
@end

@implementation HEBTakOutSKUModel
+ (NSDictionary *)modelCustomPropertyMapper {
    //被替换的key可以是多个，使用数组代表多个@[@"123",@"456"]
    return @{@"sku_id":@"id"};
}
@end
