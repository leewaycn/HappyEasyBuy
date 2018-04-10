//
//  Tools.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

/** 使用偏好设置存储数据 */
+ (BOOL)toolsUserDefaultsSaveOBJ:(id)obj forKey:(NSString *)key;

/** 使用偏好设置存储浮点数据 */
+ (BOOL)toolsUserDefaultsSaveDoubleOBJ:(double)obj forKey:(NSString *)key;

/**
 获取当前时间
 
 @param type 设置你想要的格式<YYYY-MM-dd HH:mm:ss>(hh与HH的区别:分别表示12小时制,24小时制)
 @return 带有格式的时间
 */
+ (NSString *)getCurrentTimesWithType:(NSString *)type;

/**
 设置不同颜色
 @param editString 需要修改的文本
 @param searchString 检索修改的文本
 @param firstColor 第一种颜色
 @param secondColor 第二种颜色
 @return 不同颜色的文本
 */
+ (NSMutableAttributedString *)toolsEditColorString:(NSString *)editString searchString:(NSString *)searchString firstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor;

@end
