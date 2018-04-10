//
//  UIImage+Extenison.h
//  test
//
//  Created by Dwang on 2018/1/10.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extenison)

/** 生成圆角 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

/** 截取全屏 */
+ (UIImage *)shotScreen;

/** 截取某个view */
+ (UIImage *)shotWithView:(UIView *)view;

/** 截图某个view的某块区域 */
+ (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope;

@end
