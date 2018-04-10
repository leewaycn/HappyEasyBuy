//
//  Tools.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (BOOL)toolsUserDefaultsSaveOBJ:(id)obj forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)toolsUserDefaultsSaveDoubleOBJ:(double)obj forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setDouble:obj forKey:key];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSMutableAttributedString *)toolsEditColorString:(NSString *)editString searchString:(NSString *)searchString firstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:editString];
    NSRange range = [editString rangeOfString:searchString];
    [attStr addAttribute:NSForegroundColorAttributeName value:firstColor range:NSMakeRange(0,range.location)];
    [attStr addAttribute:NSForegroundColorAttributeName value:secondColor range:NSMakeRange(range.location,searchString.length)];
    [attStr addAttribute:NSForegroundColorAttributeName value:firstColor range:NSMakeRange(range.location+searchString.length,editString.length-range.location-searchString.length)];
    return attStr;
}

+ (NSString *)getCurrentTimesWithType:(NSString *)type {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:type];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

@end
