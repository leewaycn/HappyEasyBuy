//
//  HEBHeaderToolsView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/24.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBGastronomyListHeaderToolsView : QMUIView

/** 获取点击工具视图事件 */
@property(nonatomic, copy) void (^getHeaderToolsDidClick)(NSInteger idx);

@end
