//
//  LWSettingItem.h
//  LWShopItem
//
//  Created by mac on 17/3/20.
//  Copyright © 2017年 LWShop.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWSettingItem : NSObject

//** 标题 title */
@property (nonatomic ,copy) NSString *title;

//** 图标 icon */
@property (nonatomic ,copy) NSString *icon;

@property (nonatomic ,copy) NSString *rightTitle;

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon rigthTitle:(NSString *)rightTitle;

//加方法 快速
+ (instancetype)settingItem;


@end
