//
//  ClassificationsView.h
//  test
//
//  Created by Dwang on 2017/11/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HEBClassificationModel.h"

@interface ClassificationsView : UIView
typedef void (^didClickClassifications)(HEBClassificationModel *model);
@property(nonatomic, copy) didClickClassifications didClickClassifications;

/**
 设置显示模式

 @param dataArr 数据源
 @param maxRowCount 每行最大数量
 @param maxRow 每页最大行数
 @param didClickClassifications 点击回调
 */
- (void)setClassificationsViewDataArr:(NSArray<HEBClassificationModel *> *)dataArr maxRowCount:(int)maxRowCount maxRow:(int)maxRow didClickClassifications:(didClickClassifications)didClickClassifications;

@end
