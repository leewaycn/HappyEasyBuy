//
//  DWTransform.m
//  DWTransformTest
//
//  Created by 四海全球 on 2017/5/4.
//  Copyright © 2017年 dwang. All rights reserved.
//

#import "DWTransform.h"

@interface DWTransform ()
@end

@implementation DWTransform

/**********************************************平移*******************************************/
#pragma mark - 不带动画平移
+ (void)dwTransformMakeTranslationTX:(CGFloat)tx TY:(CGFloat)ty toView:(UIView *)view {
    view.transform = CGAffineTransformMakeTranslation(tx, ty);
}
#pragma mark - 多个元素不带动画平移
+ (void)dwTransformMakeTranslationTX:(CGFloat)tx TY:(CGFloat)ty toViews:(NSArray<UIView *> *)views {
    for (UIView *view in views) {
     view.transform = CGAffineTransformMakeTranslation(tx, ty);
    }
}
#pragma mark - 不带动画累计平移
+ (void)dwCumulativeTransformMakeTranslationTX:(CGFloat)tx TY:(CGFloat)ty toView:(UIView *)view {
    view.transform = CGAffineTransformTranslate(view.transform, tx, ty);
}
#pragma mark - 多个元素不带动画累计平移
+ (void)dwCumulativeTransformMakeTranslationTX:(CGFloat)tx TY:(CGFloat)ty toViews:(NSArray<UIView *> *)views {
    for (UIView *view in views) {
        view.transform = CGAffineTransformTranslate(view.transform, tx, ty);
    }
}
#pragma mark - 带动画平移
+ (void)dwTransformMakeTranslationTX:(CGFloat)tx TY:(CGFloat)ty toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        view.transform = CGAffineTransformMakeTranslation(tx, ty);
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 多个元素带动画平移
+ (void)dwTransformMakeTranslationTX:(CGFloat)tx TY:(CGFloat)ty toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        for (UIView *view in views) {
            view.transform = CGAffineTransformMakeTranslation(tx, ty);
        }
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 带动画累计平移
+ (void)dwCumulativeTransformMakeTranslationTX:(CGFloat)tx TY:(CGFloat)ty toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        view.transform = CGAffineTransformTranslate(view.transform, tx, ty);
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 多个元素带动画累计平移
+ (void)dwCumulativeTransformMakeTranslationTX:(CGFloat)tx TY:(CGFloat)ty toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        for (UIView *view in views) {
            view.transform = CGAffineTransformTranslate(view.transform, tx, ty);
        }
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}

/**********************************************旋转*******************************************/
#pragma mark - 不带动画旋转
+ (void)dwTransformMakeRotationAngle:(CGFloat)angle toView:(UIView *)view {
    view.transform = CGAffineTransformMakeRotation(angle);
}
#pragma mark - 多个元素不带动画旋转
+ (void)dwTransformMakeRotationAngle:(CGFloat)angle toViews:(NSArray <UIView *> *)views {
    for (UIView *view in views) {
        view.transform = CGAffineTransformMakeRotation(angle);
    }
}
#pragma mark - 不带动画累计旋转
+ (void)dwCumulativeTransformMakeRotationAngle:(CGFloat)angle toView:(UIView *)view {
    view.transform = CGAffineTransformRotate(view.transform, angle);
}
#pragma mark - 多个元素不带动画累计旋转
+ (void)dwCumulativeTransformMakeRotationAngle:(CGFloat)angle toViews:(NSArray <UIView *> *)views {
    for (UIView *view in views) {
        view.transform = CGAffineTransformRotate(view.transform, angle);
    }
}
#pragma mark - 带动画旋转
+ (void)dwTransformMakeRotationAngle:(CGFloat)angle toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        view.transform = CGAffineTransformMakeRotation(angle);
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 多个元素带动画旋转
+ (void)dwTransformMakeRotationAngle:(CGFloat)angle toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        for (UIView *view in views) {
            view.transform = CGAffineTransformMakeRotation(angle);
        }
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 带动画累计旋转
+ (void)dwCumulativeTransformMakeRotationAngle:(CGFloat)angle toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        view.transform = CGAffineTransformRotate(view.transform, angle);
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 多个元素带动画累计旋转
+ (void)dwCumulativeTransformMakeRotationAngle:(CGFloat)angle toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        for (UIView *view in views) {
            view.transform = CGAffineTransformRotate(view.transform, angle);
        }
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}

/**********************************************缩放*******************************************/
#pragma mark - 不带动画缩放
+ (void)dwTransformMakeScaleSX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view {
    view.transform = CGAffineTransformMakeScale(sx, sy);
}
#pragma mark - 多个元素不带动画缩放
+ (void)dwTransformMakeScaleSX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views {
    for (UIView *view in views) {
        view.transform = CGAffineTransformMakeScale(sx, sy);
    }
}
#pragma mark - 不带动画累计缩放
+ (void)dwCumulativeTransformMakeScaleSX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view {
    view.transform = CGAffineTransformScale(view.transform, sx, sy);
}
#pragma mark - 多个元素不带动画累计缩放
+ (void)dwCumulativeTransformMakeScaleSX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views {
    for (UIView *view in views) {
        view.transform = CGAffineTransformScale(view.transform, sx, sy);
    }
}
#pragma mark - 带动画缩放
+ (void)dwTransformMakeScaleSX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        view.transform = CGAffineTransformMakeScale(sx, sy);
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 多个元素带动画缩放
+ (void)dwTransformMakeScaleSX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        for (UIView *view in views) {
            view.transform = CGAffineTransformMakeScale(sx, sy);
        }
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 带动画累计缩放
+ (void)dwCumulativeTransformMakeScaleSX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        view.transform = CGAffineTransformScale(view.transform, sx, sy);
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 多个元素带动画累计缩放
+ (void)dwCumulativeTransformMakeScaleSX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        for (UIView *view in views) {
            view.transform = CGAffineTransformScale(view.transform, sx, sy);
        }
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}

/**********************************************平移/旋转***************************************/
#pragma mark - 不带动画平移的同时旋转
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle toView:(UIView *)view {
    CGAffineTransform translation = CGAffineTransformMakeTranslation(tx, ty);
    CGAffineTransform rotateTranslation = CGAffineTransformRotate(translation, angle);
    view.transform = rotateTranslation;
}
#pragma mark - 多个元素不带动画平移的同时旋转
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle toViews:(NSArray <UIView *> *)views {
    for (UIView *view in views) {
        CGAffineTransform translation = CGAffineTransformMakeTranslation(tx, ty);
        CGAffineTransform rotateTranslation = CGAffineTransformRotate(translation, angle);
        view.transform = rotateTranslation;
    }
}
#pragma mark - 不带动画累计平移的同时旋转
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle toView:(UIView *)view {
    CGAffineTransform translation = CGAffineTransformTranslate(view.transform, tx, ty);
    CGAffineTransform rotateTranslation = CGAffineTransformRotate(translation, angle);
    view.transform = rotateTranslation;
}
#pragma mark - 多个元素不带动画累计平移的同时旋转
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle toViews:(NSArray <UIView *> *)views {
    for (UIView *view in views) {
        CGAffineTransform translation = CGAffineTransformTranslate(view.transform, tx, ty);
        CGAffineTransform rotateTranslation = CGAffineTransformRotate(translation, angle);
        view.transform = rotateTranslation;
    }
}
#pragma mark - 带动画同时平移、旋转
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform translation = CGAffineTransformMakeTranslation(tx, ty);
        CGAffineTransform rotateTranslation = CGAffineTransformRotate(translation, angle);
        view.transform = rotateTranslation;
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 多个元素带动画同时平移、旋转
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        for (UIView *view in views) {
            CGAffineTransform translation = CGAffineTransformMakeTranslation(tx, ty);
            CGAffineTransform rotateTranslation = CGAffineTransformRotate(translation, angle);
            view.transform = rotateTranslation;
        }
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 带动画累计同时平移、旋转
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform translation = CGAffineTransformTranslate(view.transform, tx, ty);
        CGAffineTransform rotateTranslation = CGAffineTransformRotate(translation, angle);
        view.transform = rotateTranslation;
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 多个元素带动画累计同时平移、旋转
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        for (UIView *view in views) {
            CGAffineTransform translation = CGAffineTransformTranslate(view.transform, tx, ty);
            CGAffineTransform rotateTranslation = CGAffineTransformRotate(translation, angle);
            view.transform = rotateTranslation;
        }
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}

/**********************************************平移/缩放***************************************/
#pragma mark - 不带动画平移的同时缩放
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view {
    CGAffineTransform translation = CGAffineTransformMakeTranslation(tx, ty);
    CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(translation, sx, sy);
    view.transform = scaleRotateTranslation;
}
#pragma mark - 多个元素不带动画平移的同时缩放
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views {
    for (UIView *view in views) {
        CGAffineTransform translation = CGAffineTransformMakeTranslation(tx, ty);
        CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(translation, sx, sy);
        view.transform = scaleRotateTranslation;
    }
}
#pragma mark - 不带动画累计平移的同时缩放
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view {
    CGAffineTransform translation = CGAffineTransformTranslate(view.transform, tx, ty);
    CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(translation, sx, sy);
    view.transform = scaleRotateTranslation;
}
#pragma mark - 多个元素不带动画累计平移的同时缩放
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views {
    for (UIView *view in views) {
        CGAffineTransform translation = CGAffineTransformTranslate(view.transform, tx, ty);
        CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(translation, sx, sy);
        view.transform = scaleRotateTranslation;
    }
}
#pragma mark - 带动画平移的同时缩放
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform translation = CGAffineTransformMakeTranslation(tx, ty);
        CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(translation, sx, sy);
        view.transform = scaleRotateTranslation;
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 多个元素带动画平移的同时缩放
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        for (UIView *view in views) {
            CGAffineTransform translation = CGAffineTransformMakeTranslation(tx, ty);
            CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(translation, sx, sy);
            view.transform = scaleRotateTranslation;
        }
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 带动画累计平移的同时缩放
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform translation = CGAffineTransformTranslate(view.transform, tx, ty);
        CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(translation, sx, sy);
        view.transform = scaleRotateTranslation;
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 多个元素带动画累计平移的同时缩放
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        for (UIView *view in views) {
            CGAffineTransform translation = CGAffineTransformTranslate(view.transform, tx, ty);
            CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(translation, sx, sy);
            view.transform = scaleRotateTranslation;
        }
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}

/**********************************************旋转/缩放***************************************/
#pragma mark - 不带动画旋转的同时缩放
+ (void)dwTransformMakeAngle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view {
    CGAffineTransform rotateTranslation = CGAffineTransformMakeRotation(angle);
    CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(rotateTranslation, sx, sy);
    view.transform = scaleRotateTranslation;
}
#pragma mark - 多个元素不带动画旋转的同时缩放
+ (void)dwTransformMakeAngle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views {
    for (UIView *view in views) {
        CGAffineTransform rotateTranslation = CGAffineTransformMakeRotation(angle);
        CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(rotateTranslation, sx, sy);
        view.transform = scaleRotateTranslation;
    }
}
#pragma mark - 不带动画累计旋转的同时缩放
+ (void)dwCumulativeTransformMakeAngle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view {
    CGAffineTransform rotateTranslation = CGAffineTransformRotate(view.transform, angle);
    CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(rotateTranslation, sx, sy);
    view.transform = scaleRotateTranslation;
}
#pragma mark - 多个元素不带动画累计旋转的同时缩放
+ (void)dwCumulativeTransformMakeAngle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views {
    for (UIView *view in views) {
        CGAffineTransform rotateTranslation = CGAffineTransformRotate(view.transform, angle);
        CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(rotateTranslation, sx, sy);
        view.transform = scaleRotateTranslation;
    }
}
#pragma mark - 带动画旋转的同时缩放
+ (void)dwTransformMakeAngle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform rotateTranslation = CGAffineTransformMakeRotation(angle);
        CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(rotateTranslation, sx, sy);
        view.transform = scaleRotateTranslation;
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 多个元素带动画旋转的同时缩放
+ (void)dwTransformMakeAngle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        for (UIView *view in views) {
            CGAffineTransform rotateTranslation = CGAffineTransformMakeRotation(angle);
            CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(rotateTranslation, sx, sy);
            view.transform = scaleRotateTranslation;
        }
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 带动画累计旋转的同时缩放
+ (void)dwCumulativeTransformMakeAngle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform rotateTranslation = CGAffineTransformRotate(view.transform, angle);
        CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(rotateTranslation, sx, sy);
        view.transform = scaleRotateTranslation;
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 多个元素带动画累计旋转的同时缩放
+ (void)dwCumulativeTransformMakeAngle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        for (UIView *view in views) {
            CGAffineTransform rotateTranslation = CGAffineTransformRotate(view.transform, angle);
            CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(rotateTranslation, sx, sy);
            view.transform = scaleRotateTranslation;
        }
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}

/**********************************************平移/旋转/缩放**********************************/
#pragma mark - 不带动画同时平移、旋转、缩放
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view {
    CGAffineTransform translation = CGAffineTransformMakeTranslation(tx, ty);
    CGAffineTransform rotateTranslation = CGAffineTransformRotate(translation, angle);
    CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(rotateTranslation, sx, sy);
    view.transform = scaleRotateTranslation;
}
#pragma mark - 多个元素不带动画同时平移、旋转、缩放
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views {
    for (UIView *view in views) {
        CGAffineTransform translation = CGAffineTransformMakeTranslation(tx, ty);
        CGAffineTransform rotateTranslation = CGAffineTransformRotate(translation, angle);
        CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(rotateTranslation, sx, sy);
        view.transform = scaleRotateTranslation;
    }
}
#pragma mark - 不带动画累计同时平移、旋转、缩放
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view {
    CGAffineTransform translation = CGAffineTransformTranslate(view.transform, tx, ty);
    CGAffineTransform rotateTranslation = CGAffineTransformRotate(translation, angle);
    CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(rotateTranslation, sx, sy);
    view.transform = scaleRotateTranslation;
}
#pragma mark - 多个元素不带动画累计同时平移、旋转、缩放
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views {
    for (UIView *view in views) {
        CGAffineTransform translation = CGAffineTransformTranslate(view.transform, tx, ty);
        CGAffineTransform rotateTranslation = CGAffineTransformRotate(translation, angle);
        CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(rotateTranslation, sx, sy);
        view.transform = scaleRotateTranslation;
    }
}
#pragma mark - 带动画同时平移、旋转、缩放
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform translation = CGAffineTransformMakeTranslation(tx, ty);
        CGAffineTransform rotateTranslation = CGAffineTransformRotate(translation, angle);
        CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(rotateTranslation, sx, sy);
        view.transform = scaleRotateTranslation;
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 多个元素带动画同时平移、旋转、缩放
+ (void)dwTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        for (UIView *view in views) {
            CGAffineTransform translation = CGAffineTransformMakeTranslation(tx, ty);
            CGAffineTransform rotateTranslation = CGAffineTransformRotate(translation, angle);
            CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(rotateTranslation, sx, sy);
            view.transform = scaleRotateTranslation;
        }
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 带动画累计同时平移、旋转、缩放
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform translation = CGAffineTransformTranslate(view.transform, tx, ty);
        CGAffineTransform rotateTranslation = CGAffineTransformRotate(translation, angle);
        CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(rotateTranslation, sx, sy);
        view.transform = scaleRotateTranslation;
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 多个元素带动画累计同时平移、旋转、缩放
+ (void)dwCumulativeTransformMakeTX:(CGFloat)tx TY:(CGFloat)ty Angle:(CGFloat)angle SX:(CGFloat)sx SY:(CGFloat)sy toViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        for (UIView *view in views) {
            CGAffineTransform translation = CGAffineTransformTranslate(view.transform, tx, ty);
            CGAffineTransform rotateTranslation = CGAffineTransformRotate(translation, angle);
            CGAffineTransform scaleRotateTranslation = CGAffineTransformScale(rotateTranslation, sx, sy);
            view.transform = scaleRotateTranslation;
        }
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}

/**********************************************删除****************************************/
#pragma mark - 不带动画删除transform
+ (void)dwRemoveAllTransformToView:(UIView *)view {
    view.transform = CGAffineTransformIdentity;
}
#pragma mark - 多个元素不带动画删除transform
+ (void)dwRemoveAllTransformToViews:(NSArray <UIView *> *)views {
    for (UIView *view in views) {
        view.transform = CGAffineTransformIdentity;
    }
}
#pragma mark - 带动画删除transform
+ (void)dwRemoveAllTransformToView:(UIView *)view animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        view.transform = CGAffineTransformIdentity;
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
#pragma mark - 多个元素带动画删除transform
+ (void)dwRemoveAllTransformToViews:(NSArray <UIView *> *)views animateWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        for (UIView *view in views) {
            view.transform = CGAffineTransformIdentity;
        }
        animations();
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}
@end
