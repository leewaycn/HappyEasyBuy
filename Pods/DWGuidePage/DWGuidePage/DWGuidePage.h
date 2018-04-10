//
//  DWGuidePage.h
//  DWGuidePage.h
//
//  Created by dwang_sui on 2016/11/8.
//  Copyright © 2016年 dwang. All rights reserved.
//
/*******************Github:https://github.com/CoderDwang/DWGuidePage********************/
/*****************************邮箱:coderdwang@outlook.com********************************/
/*****************************QQ交流群:577506623*********************************/
/*****************************codedata官方群:157937068***************************/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TAPageController.h"

@protocol DWGuidePageDelegate<NSObject>
@optional
/** 获取当前所在idx */
- (void)guidePageWithCurrentIdx:(NSInteger)currentIdx;

/** 获取当前所在idx与运动状态 */
- (void)guidePageWithCurrentIdx:(NSInteger)currentIdx andCurrentX:(CGFloat)currentX slipPageEnd:(BOOL)isSlipEnd;

@end

@interface DWGuidePage : UIView

/** 背景颜色/默认白色 */
@property(strong, nonatomic) UIColor   *guidePageBGColor;

/** 第一张时是否开启图片拉升动画/默认开启(rightEnabled此时失效) */
@property(nonatomic, assign) BOOL        rightAnimation;

/** 最后一张时是否开启图片拉升动画/默认开启(leftEnabled此时失效) */
@property(nonatomic, assign) BOOL        leftAnimation;

/** 最后一张可滑动的距离/默认为25.00 */
@property(nonatomic, assign) CGFloat     lastDistance;

/** 第一张时是否允许继续右滑/默认NO */
@property(assign, nonatomic) BOOL        rightEnabled;

/** 最后一张时是否允许继续左滑/默认NO */
@property(assign, nonatomic) BOOL        leftEnabled;

/** 是否显示pageControl/默认NO(不隐藏) */
@property(assign, nonatomic) BOOL        pageHidden;

/** pageControl未选中时图片 */
@property(strong, nonatomic) UIImage    *pageNormalImage;

/** pageControl选中时的图片 */
@property(strong, nonatomic) UIImage    *pageCurrentImage;

/** pageControl的Y值 */
@property(assign, nonatomic) CGFloat     pageY;

/** pageContro/更多自定义page可是此属性 */
@property (strong, nonatomic) TAPageController *pageControl;

/** 图片内容/可用于添加内容 */
@property(nonatomic, strong, readonly) NSArray<UIImageView *> *imgs;

@property(nonatomic, weak) id <DWGuidePageDelegate>delegate;

typedef void (^DWGuidePageCurrentIdx)(NSInteger currentIdx);
@property(nonatomic, copy) DWGuidePageCurrentIdx guidePageCurrentIdx;

typedef void (^DWGuidePageCurrentIdxAndCurrentX)(NSInteger currentIdx, CGFloat currentX, BOOL isSlipPageEnd);
@property(nonatomic, copy) DWGuidePageCurrentIdxAndCurrentX guidePageCurrentIdxAndCurrentX;

/** 是否每次版本改变都会出现GuidePage/默认为YES(此方法需要在Applegate中执行) */
+ (void)setEveryVersionChangeEnabled:(BOOL)enabled;

/**
 AppDelegate中调用

 @param window 主window
 @param guidePageViewController 引导页控制器
 @param mainViewController 首页控制器
 */
+ (void)configAppWindow:(UIWindow *)window fromGuidePgaeViewController:(UIViewController *)guidePageViewController toMainViewController:(UIViewController *)mainViewController;

/**
 初始化

 @param imgsArray 数据源（支持NSString/UIImage）
 @param guidePageCurrentIdx block回调
 @return DWGuidePage
 */
- (instancetype)initWithImgsArray:(NSArray *)imgsArray guidePageCurrentIdx:(DWGuidePageCurrentIdx)guidePageCurrentIdx guidePageCurrentIdxAndCurrentX:(DWGuidePageCurrentIdxAndCurrentX)guidePageCurrentIdxAndCurrentX;

@end
