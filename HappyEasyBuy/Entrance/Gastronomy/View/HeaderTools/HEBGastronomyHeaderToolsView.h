//
//  HEBGastronomyHeaderToolsView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/23.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBGastronomyHeaderToolsView : QMUIView

/** 获取工具视图点击事件 */
@property(nonatomic, copy) void (^getHeaderToolsDidClick)(NSInteger idx);

/** 临时存储按钮 */
@property(nonatomic, strong) NSMutableArray <QMUIButton *> *btnArrM;

@end
