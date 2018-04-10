//
//  HEBVicinityView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBGuessYlikeView.h"
#import "HEBScreeningView.h"
#import "HEBSequencingView.h"
#import "HEBGuessYlikeHeaderView.h"

@interface HEBVicinityView : QMUIView

/** 获取筛选框点击内容 */
@property(nonatomic, copy) void (^getguessYlikeDidClick)(QMUIButton *sender);

/** 获取筛选内容 */
@property(nonatomic, copy) void (^getScreeningDidClick)(NSInteger idx);

/** 获取筛选内容 */
@property(nonatomic, copy) void (^getSelectScreeningINFO)(NSDictionary *selectINFO);

/** 数据源 */
@property(nonatomic, strong) NSMutableArray <HEBGuessYlikeModel *> *cellModelArrM;

/** 排序选项model */
@property(nonatomic, strong) NSArray *sequencingCellModelArr;

/** 商家特色数据源 */
@property(nonatomic, strong) NSArray *shopCellModelArr;

/** 人均价数据源 */
@property(nonatomic, strong) NSArray *moneyCellModelArr;

/** 内容视图 */
@property(nonatomic, strong) QMUITableView *tableView;

/** 临时存储，防止多次创建 */
@property(nonatomic, strong) HEBSequencingView *sequencingView;
@property(nonatomic, strong) HEBScreeningView *screeningView;

/** 顶部工具视图 */
@property(nonatomic, strong) HEBGuessYlikeHeaderView *toolsView;

@end
