//
//  HEBGuessYlikeHeaderView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBGuessYlikeHeaderView : QMUIView

/** 不同选项的点击事件 */
@property(nonatomic, copy) void (^guessYlikeHeaderViewDidClick)(QMUIButton *sender);

- (void)loadHeaderView;

/** 顶部文字 */
@property(nonatomic, copy) NSString *lab;

/** 排序方式 */
@property(nonatomic, copy) NSString *sequencingMsg;

/** 存储工具按钮 */
@property(nonatomic, strong) NSMutableArray<QMUIButton *> *btnArrM;

@end
