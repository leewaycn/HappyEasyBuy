//
//  NSString+CBExtension.h
//  ClipboardTool_iOS
//
//  Created by dawng on 2017/8/29.
//  Copyright © 2017年 dwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HEBExtension)

/** 去除- */
@property(nonatomic, copy, readonly) NSString *removeline;

/** 去除空格 */
@property(nonatomic, copy, readonly) NSString *removeSpace;

/** 格式化字符串，去除@"¥" */
@property(nonatomic, copy, readonly) NSString *removeMoneySymbol;

/** 手机号中间四位加密 */
@property(nonatomic, copy, readonly) NSString *encryptMobNumber;

/** 拨打电话 */
@property(nonatomic, assign) BOOL callPhone;

/** 获取偏好设置存储信息 */
@property(nonatomic, assign, readonly) id getUserDefaultsINFO;

/** 删除偏好设置存储信息 */
@property(nonatomic, assign) BOOL removeUserDefaultsINFO;

/** 时间戳转时间<yyyy.MM.dd> */
@property(nonatomic, copy, readonly) NSString *timeStampYYYYMMDDPoint;

/** 时间戳转时间<yyyy-MM-dd hh:mm:ss> */
@property(nonatomic, copy, readonly) NSString *timeStampYYYYMMDDHHMMSS;

/** 计算字号为12边距为30的字符高度 */
@property(nonatomic, assign, readonly) CGFloat heightWith12_30;

/** 计算字号为14边距为30的字符高度 */
@property(nonatomic, assign, readonly) CGFloat heightWith14_30;

/** 计算字号为14边距为90的字符高度 */
@property(nonatomic, assign, readonly) CGFloat heightWith14_90;

/** 获取字符宽度 */
- (CGFloat)stringWidthWithFontSize:(float)size;

@end
