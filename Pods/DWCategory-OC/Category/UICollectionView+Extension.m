//
//  UICollectionView+Extension.m
//  test
//
//  Created by Dwang on 2018/1/10.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "UICollectionView+Extension.h"
#import <objc/runtime.h>

@protocol CDCollectionViewDelegat <NSObject>
@optional

/** 完全自定义占位图 */
- (UIView *)cd_noDataView;

/** 使用默认占位图, 提供一张图片, 可不提供, 默认不显示 */
- (UIImage *)cd_noDataViewImage;

/** 使用默认占位图, 提供显示文字, 可不提供, 默认为暂无数据 */
- (NSString *)cd_noDataViewMessage;

/** 使用默认占位图, 提供显示文字颜色, 可不提供, 默认为灰色 */
- (UIColor *)cd_noDataViewMessageColor;

/** 使用默认字体, 提供显示文字字体, 可不提供, 默认为系统字体、字号17 */
- (UIFont *)cd_noDataViewMessageFont;

/** 出现数据时会走此代理 */
- (void)cd_hasData;

@end

@implementation UICollectionView (Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method sysMethod = class_getInstanceMethod(self, @selector(reloadData));
        Method cd_Method = class_getInstanceMethod(self, @selector(cd_reloadData));
        method_exchangeImplementations(sysMethod, cd_Method);
    });
}

- (void)cd_reloadData {
    [self cd_reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger numberOfSection = [self numberOfSections];
        BOOL hasData = NO;
        for (int i = 0; i < numberOfSection; i ++) {
            if ([self numberOfItemsInSection:i]) {
                hasData = YES;
                break;
            }
        }
        [self cd_hasData:hasData];
    });
}

- (void)cd_hasData:(BOOL)hasData {
    if (hasData) {
        self.backgroundView = nil;
        if ([self.delegate respondsToSelector:@selector(cd_hasData)]) {
            [self.delegate performSelector:@selector(cd_hasData)];
        }
        return;
    }
    if ([self.delegate respondsToSelector:@selector(cd_noDataView)]) {
        self.backgroundView = [self.delegate performSelector:@selector(cd_noDataView)];
        return;
    }
    
    UIImage *img = nil;
    NSString *msg = @"暂无数据";
    UIColor *msgColor = [UIColor lightGrayColor];
    UIFont *msgFont = [UIFont systemFontOfSize:17];
    if ([self.delegate respondsToSelector:@selector(cd_noDataViewImage)]) {
        img = [self.delegate performSelector:@selector(cd_noDataViewImage)];
    }
    if ([self.delegate respondsToSelector:@selector(cd_noDataViewMessage)]) {
        msg = [self.delegate performSelector:@selector(cd_noDataViewMessage)];
    }
    if ([self.delegate respondsToSelector:@selector(cd_noDataViewMessageColor)]) {
        msgColor = [self.delegate performSelector:@selector(cd_noDataViewMessageColor)];
    }
    if ([self.delegate respondsToSelector:@selector(cd_noDataViewMessageFont)]) {
        msgFont = [self.delegate performSelector:@selector(cd_noDataViewMessageFont)];
    }
    if (img) {
        self.backgroundView = [self cd_defaultNoDataViewWithImage:img message:msg msgColor:msgColor msgFont:msgFont];
    }else {
        self.backgroundView = [self cd_defaultNoDataViewWithMessage:msg msgColor:msgColor msgFont:msgFont];
    }
}

- (UIView *)cd_defaultNoDataViewWithMessage:(NSString *)message msgColor:(UIColor *)msgColor msgFont:(UIFont *)msgFont {
    UILabel *lab = [[UILabel alloc] init];
    lab.text = message;
    lab.textColor = msgColor;
    lab.font = msgFont;
    lab.textAlignment = NSTextAlignmentCenter;
    [lab sizeToFit];
    return lab;
}

- (UIView *)cd_defaultNoDataViewWithImage:(UIImage *)image message:(NSString *)message msgColor:(UIColor *)msgColor msgFont:(UIFont *)msgFont {
    CGFloat cX = self.bounds.size.width/2;
    CGFloat cY = self.bounds.size.height * (1 - 0.618);
    CGFloat iW = image.size.width;
    CGFloat iH = image.size.height;
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(cX - iW / 2, cY - iH / 2, iW, iH);
    imgView.image = image;
    
    UILabel *lab = [[UILabel alloc] init];
    lab.text = message;
    lab.textColor = msgColor;
    lab.font = msgFont;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.frame = CGRectMake(0, CGRectGetMaxY(imgView.frame)+24, self.bounds.size.width, lab.font.lineHeight);
    
    UIView *bgView = [[UIView alloc] init];
    [bgView addSubview:imgView];
    [bgView addSubview:lab];
    return bgView;
}

@end
