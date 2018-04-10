//
//  HEBBaseViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBBaseViewController : QMUICommonViewController

/** 使用ScrollerView替换控制器自带View */
@property(nonatomic, strong) UIScrollView *baseView;

/** 进度指示器 */
@property(nonatomic, strong) MBProgressHUD *progressHUD;

/** 关闭进度指示器 */
- (void)dismissProgressHUD;

/** 设置导航视图透明 */
- (void)setNavigationBarTransparence;

@end
