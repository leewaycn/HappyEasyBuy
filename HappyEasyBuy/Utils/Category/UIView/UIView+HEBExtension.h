//
//  UIView+HEBExtension.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HEBExtension)

/** 是否设置顶部分界线 */
@property(nonatomic, assign) BOOL dividingLine;

/** 是否设置底部分界线 */
@property(nonatomic, assign) BOOL bottomLine;

/** 返回当前控制器 */
@property(nonatomic, strong) HEBBaseViewController *viewControl;

@end
