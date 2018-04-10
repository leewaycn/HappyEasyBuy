//
//  UIView+HEBExtension.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "UIView+HEBExtension.h"

@implementation UIView (HEBExtension)
@dynamic dividingLine;
@dynamic bottomLine;
@dynamic viewControl;

- (void)setDividingLine:(BOOL)dividingLine {
    if (dividingLine) {
        self.qmui_borderWidth = 1.f;
        self.qmui_borderColor = UIColorHex(#e7e7e7);
        self.qmui_borderPosition = QMUIBorderViewPositionTop;
    }
}

- (void)setBottomLine:(BOOL)bottomLine {
    if (bottomLine) {
        self.qmui_borderWidth = 1.f;
        self.qmui_borderColor = UIColorHex(#e7e7e7);
        self.qmui_borderPosition = QMUIBorderViewPositionBottom;
    }
}

- (HEBBaseViewController *)viewControl {
    return (HEBBaseViewController *)self.viewController;
}

@end
