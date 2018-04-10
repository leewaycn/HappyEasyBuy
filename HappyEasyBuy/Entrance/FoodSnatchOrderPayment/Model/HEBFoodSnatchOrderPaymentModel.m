//
//  HEBFoodSnatchOrderPaymentModel.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBFoodSnatchOrderPaymentModel.h"

@implementation HEBFoodSnatchOrderPaymentModel
@end

@implementation HEBFoodSnatchOrderPaymentCouponModel
@end

@implementation HEBFoodSnatchOrderPaymentCouponDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"objid":@"id"};
}
@end

@implementation HEBFoodSnatchOrderPaymentRedDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"objid":@"id"};
}
@end
