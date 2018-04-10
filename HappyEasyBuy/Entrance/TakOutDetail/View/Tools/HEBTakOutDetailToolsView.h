//
//  HEBTakOutDetailToolsView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/9.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBTakOutDetailToolsView : QMUIView

/** 获取点击的工具 */
@property(nonatomic, copy) void (^getTakOutToolsDidClick)(NSInteger idx);

@end
