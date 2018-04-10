//
//  LWSettingItem.m
//  LWShopItem
//
//  Created by mac on 17/3/20.
//  Copyright © 2017年 LWShop.com. All rights reserved.
//

#import "LWSettingItem.h"

@implementation LWSettingItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon rigthTitle:(NSString *)rightTitle
{
    LWSettingItem *item = [self settingItem];
    item.title = title;
    item.icon = icon;
    item.rightTitle = rightTitle;
    return item;
}
+ (instancetype)settingItem
{
    return [[self alloc] init];
}


@end
