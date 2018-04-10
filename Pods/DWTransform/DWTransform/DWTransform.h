 //
//  DWTransform.h
//  DWTransformTest
//
//  Created by 四海全球 on 2017/5/4.
//  Copyright © 2017年 dwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface DWTransform : NSObject

/**********************************************平移*******************************************/

/**
 不带动画平移

 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param view 添加平移的所在对象
 */
+ (void)dwTransformMakeTranslationTX:(CGFloat)tx TY:(CGFloat)ty toView:(UIView *)view;

/**
 多个元素不带动画平移

 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param views 添加平移的所在对象数组
 */
+ (void)dwTransformMakeTranslationTX:(CGFloat)tx TY:(CGFloat)ty toViews:(NSArray<UIView *> *)views;

/**
 不带动画累计平移

 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param view 添加平移的所在对象
 */
+ (void)dwCumulativeTransformMakeTranslationTX:(CGFloat)tx TY:(CGFloat)ty toView:(UIView *)view;

/**
 多个元素不带动画累计平移

 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param views 添加平移的所在对象数组
 */
+ (void)dwCumulativeTransformMakeTranslationTX:(CGFloat)tx TY:(CGFloat)ty toViews:(NSArray<UIView *> *)views;

/**
 带动画平移

 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param view 添加平移的所在对象
 @param duration 动画执行时间
 @param animations 动画开始执行
 @param completion 动画执行完成之后的回调
 */
+ (void)dwTransformMakeTranslationTX:(CGFloat)tx TY:(CGFloat)ty toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 多个元素带动画平移
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param views 添加平移的所在对象数组
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwTransformMakeTranslationTX:(CGFloat)tx TY:(CGFloat)ty toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 带动画累计平移
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param view 添加平移的所在对象
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwCumulativeTransformMakeTranslationTX:(CGFloat)tx TY:(CGFloat)ty toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 多个元素带动画累计平移

 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param views 添加平移的所在对象数组
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwCumulativeTransformMakeTranslationTX:(CGFloat)tx TY:(CGFloat)ty toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;


/**********************************************旋转*******************************************/

/**
 不带动画旋转

 @param angle 旋转角度
 @param view 添加旋转的所在对象
 */
+ (void)dwTransformMakeRotationAngle:(CGFloat)angle toView:(UIView *)view;

/**
 多个元素不带动画旋转
 
 @param angle 旋转角度
 @param views 添加旋转的所在对象数组
 */
+ (void)dwTransformMakeRotationAngle:(CGFloat)angle toViews:(NSArray <UIView *> *)views;

/**
 不带动画累计旋转
 
 @param angle 旋转角度
 @param view 添加旋转的所在对象
 */
+ (void)dwCumulativeTransformMakeRotationAngle:(CGFloat)angle toView:(UIView *)view;

/**
 多个元素不带动画累计旋转
 
 @param angle 旋转角度
 @param views 添加旋转的所在对象数组
 */
+ (void)dwCumulativeTransformMakeRotationAngle:(CGFloat)angle toViews:(NSArray <UIView *> *)views;

/**
 带动画旋转

 @param angle 旋转角度
 @param view 添加旋转的所在对象
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwTransformMakeRotationAngle:(CGFloat)angle toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 多个元素带动画旋转
 
 @param angle 旋转角度
 @param views 添加旋转的所在对象数组
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwTransformMakeRotationAngle:(CGFloat)angle toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 带动画累计旋转
 
 @param angle 旋转角度
 @param view 添加旋转的所在对象
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwCumulativeTransformMakeRotationAngle:(CGFloat)angle toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 多个元素带动画累计旋转
 
 @param angle 旋转角度
 @param views 添加旋转的所在对象数组
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwCumulativeTransformMakeRotationAngle:(CGFloat)angle toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;


/**********************************************缩放*******************************************/

/**
 不带动画缩放

 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param view 添加缩放的所在对象
 */
+ (void)dwTransformMakeScaleSX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view;

/**
 多个元素不带动画缩放
 
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param views 添加缩放的所在对象数组
 */
+ (void)dwTransformMakeScaleSX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views;

/**
 不带动画累计缩放
 
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param view 添加缩放的所在对象
 */
+ (void)dwCumulativeTransformMakeScaleSX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view;

/**
 多个元素不带动画累计缩放
 
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param views 添加缩放的所在对象数组
 */
+ (void)dwCumulativeTransformMakeScaleSX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views;

/**
 带动画缩放

 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param view 添加缩放的所在对象
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwTransformMakeScaleSX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 多个元素带动画缩放
 
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param views 添加缩放的所在对象数组
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwTransformMakeScaleSX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 带动画累计缩放
 
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param view 添加缩放的所在对象
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwCumulativeTransformMakeScaleSX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 多个元素带动画累计缩放
 
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param views 添加缩放的所在对象数组
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwCumulativeTransformMakeScaleSX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;


/**********************************************平移/旋转***************************************/

/**
 不带动画同时平移、旋转

 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param angle 旋转角度
 @param view 添加平移、旋转的所在对象
 */
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle toView:(UIView *)view;

/**
 多个元素不带动画同时平移、旋转
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param angle 旋转角度
 @param views 添加平移、旋转的所在对象数组
 */
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle toViews:(NSArray <UIView *> *)views;

/**
 不带动画累计同时平移、旋转
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param angle 旋转角度
 @param view 添加平移、旋转的所在对象
 */
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle toView:(UIView *)view;

/**
 多个元素不带动画累计同时平移、旋转
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param angle 旋转角度
 @param views 添加平移、旋转的所在对象数组
 */
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle toViews:(NSArray <UIView *> *)views;

/**
 带动画同时平移、旋转
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param angle 旋转角度
 @param view 添加平移、旋转的所在对象
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 多个元素带动画同时平移、旋转
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param angle 旋转角度
 @param views 添加平移、旋转的所在对象数组
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 带动画累计同时平移、旋转
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param angle 旋转角度
 @param view 添加平移、旋转的所在对象
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 多个元素带动画累计同时平移、旋转
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param angle 旋转角度
 @param views 添加平移、旋转的所在对象数组
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;


/**********************************************平移/缩放***************************************/

/**
 不带动画同时平移、缩放

 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param view 添加平移、缩放的所在对象
 */
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view;

/**
 多个元素不带动画同时平移、缩放
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param views 添加平移、缩放的所在对象数组
 */
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views;

/**
 不带动画累计同时平移、缩放
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param view 添加平移、缩放的所在对象
 */
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view;

/**
 多个元素不带动画累计同时平移、缩放
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param views 添加平移、缩放的所在对象数组
 */
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views;

/**
 带动画同时平移、缩放

 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param view 添加平移、缩放的所在对象
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 多个元素带动画同时平移、缩放
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param views 添加平移、缩放的所在对象数组
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 带动画累计同时平移、缩放
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param view 添加平移、缩放的所在对象
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 多个元素带动画累计同时平移、缩放
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param views 添加平移、缩放的所在对象数组
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;


/**********************************************旋转/缩放***************************************/

/**
 不带动画同时旋转、缩放
 
 @param angle 旋转角度
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param view 添加旋转、缩放的所在对象
 */
+ (void)dwTransformMakeAngle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view;

/**
 多个元素不带动画同时旋转、缩放
 
 @param angle 旋转角度
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param views 添加旋转、缩放的所在对象数组
 */
+ (void)dwTransformMakeAngle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views;

/**
 不带动画累计同时旋转、缩放
 
 @param angle 旋转角度
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param view 添加旋转、缩放的所在对象
 */
+ (void)dwCumulativeTransformMakeAngle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view;

/**
 多个元素不带动画累计同时旋转、缩放
 
 @param angle 旋转角度
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param views 添加旋转、缩放的所在对象数组
 */
+ (void)dwCumulativeTransformMakeAngle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views;

/**
 带动画同时旋转、缩放
 
 @param angle 旋转角度
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param view 添加旋转、缩放的所在对象
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwTransformMakeAngle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 多个元素带动画同时旋转、缩放
 
 @param angle 旋转角度
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param views 添加旋转、缩放的所在对象数组
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwTransformMakeAngle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 带动画累计同时旋转、缩放
 
 @param angle 旋转角度
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param view 添加旋转、缩放的所在对象
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwCumulativeTransformMakeAngle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 多个元素带动画累计同时旋转、缩放
 
 @param angle 旋转角度
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param views 添加旋转、缩放的所在对象数组
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwCumulativeTransformMakeAngle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;


/**********************************************平移/旋转/缩放**********************************/

/**
 不带动画同时平移、旋转、缩放

 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param angle 旋转角度
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param view 添加平移、旋转、缩放的所在对象
 */
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view;

/**
 多个元素不带动画同时平移、旋转、缩放
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param angle 旋转角度
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param views 添加平移、旋转、缩放的所在对象数组
 */
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views;

/**
 不带动画累计同时平移、旋转、缩放
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param angle 旋转角度
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param view 添加平移、旋转、缩放的所在对象
 */
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view;

/**
 多个元素不带动画累计同时平移、旋转、缩放
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param angle 旋转角度
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param views 添加平移、旋转、缩放的所在对象数组
 */
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views;

/**
 带动画同时平移、旋转、缩放

 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param angle 旋转角度
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param view 添加平移、旋转、缩放的所在对象
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 多个元素带动画同时平移、旋转、缩放
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param angle 旋转角度
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param views 添加平移、旋转、缩放的所在对象数组
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 带动画累计同时平移、旋转、缩放
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param angle 旋转角度
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param view 添加平移、旋转、缩放的所在对象
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 多个元素带动画累计同时平移、旋转、缩放
 
 @param tx X轴的平移数
 @param ty Y轴的平移数
 @param angle 旋转角度
 @param sx X轴的缩放比例
 @param sy Y轴的缩放比例
 @param views 添加平移、旋转、缩放的所在对象数组
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;


/**********************************************删除****************************************/

/**
 不带动画清空transform
 
 @param view 删除transform属性的所在对象
 */
+ (void)dwRemoveAllTransformToView:(UIView *)view;

/**
 多个元素不带动画清空transform
 
 @param views 删除transform属性的所在对象数组
 */
+ (void)dwRemoveAllTransformToViews:(NSArray <UIView *> *)views;

/**
 带动画清空transform

 @param view 删除transform属性的所在对象
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwRemoveAllTransformToView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 多个元素带动画清空transform
 
 @param views 删除transform属性的所在对象数组
 @param duration 动画执行时间
 @param completion 动画执行完成之后的回调
 */
+ (void)dwRemoveAllTransformToViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration  animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

@end
