//
//  HEBScreeningView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/18.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBScreeningView : QMUITableView

/** 商家特色数据源 */
@property(nonatomic, strong) NSArray <NSDictionary *> *shopCellModelArr;

/** 人均价数据源 */
@property(nonatomic, strong) NSArray <NSDictionary *> *moneyCellModelArr;

/** 获取选中的信息 */
@property(nonatomic, copy) void (^getSelectScreeningINFO)(NSDictionary *selectINFO, NSArray *shopCellModelArr, NSArray *moneyCellModelArr);

@end
