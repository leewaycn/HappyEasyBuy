//
//  MTCategoryView.h
//  MT_waimai[007]
//
//  Created by HM on 16/8/5.
//  Copyright © 2016年 HM. All rights reserved.
//  中间三个按钮及黄色条子的视图

#import "MTBaseControl.h"
#import "CZAdditions.h"

@interface MTCategoryView : MTBaseControl

/**
 *  滚动视图滚动后,传过来的让黄条滚动的距离!
 */
@property (assign, nonatomic) CGFloat offset_x;

/**
 *  需要滚动到的页码
 */
@property (assign, nonatomic) NSInteger pageNumber;

@end
