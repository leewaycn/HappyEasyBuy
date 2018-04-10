//
//  HEBHeaderToolsView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBOrderListHeaderToolsView : QMUIView

/** 获取头部工具的点击事件 */
@property(nonatomic, copy) void (^getHeaderToolsDidCick)(NSString *toolName, NSInteger tag);

/** 工具视图内容 */
@property(nonatomic, strong) NSArray<NSString *> *toolsArr;

- (void)loadToolsView;

@end
