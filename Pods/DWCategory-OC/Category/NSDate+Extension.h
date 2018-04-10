//
//  NSDate+Extension.h
//  test
//
//  Created by Dwang on 2018/1/10.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 获取当前时间
 
 @param format 设置你想要的格式<YYYY-MM-dd HH:mm:ss>(hh与HH的区别:分别表示12小时制,24小时制)
 @return 带有格式的时间
 */
+ (NSString *)currentTimeWithFormat:(NSString *)format;

/**
 时间戳转时间

 @param timeStamp 时间戳
 @param format 时间格式
 @return 带有格式的时间
 */
+ (NSString *)timeStamp:(NSString *)timeStamp withFormat:(NSString *)format;

@end
