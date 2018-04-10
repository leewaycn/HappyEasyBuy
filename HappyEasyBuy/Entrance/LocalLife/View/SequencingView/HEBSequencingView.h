//
//  HEBScreeningView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBSequencingView : QMUITableView

/** 筛选视图数据源 */
@property(nonatomic, strong) NSArray<NSDictionary *> *cellModelArr;

@property(nonatomic, copy) void (^changeCellModelArr)(NSArray *cellModelArr, NSInteger idx);

@end
