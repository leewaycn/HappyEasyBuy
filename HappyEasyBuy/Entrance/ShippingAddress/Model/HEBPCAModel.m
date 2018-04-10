//
//  HEBCityModel.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/27.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBPCAModel.h"

@implementation HEBPCAModel

- (NSArray<HEBCityModel *> *)city {
    return [NSArray yy_modelArrayWithClass:[HEBCityModel class] json:_city];
}

@end

@implementation HEBCityModel

@end

