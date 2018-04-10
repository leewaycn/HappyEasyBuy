//
//  HEBLocationView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/26.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBLocationModel.h"

@interface HEBLocationView : QMUITableView

/** 当前点击cell是否为进入修改信息界面 */
@property(nonatomic, assign) BOOL getConsignee;

/** 数据源 */
@property(nonatomic, strong) NSMutableArray<HEBLocationModel *> *locationModelArr;

/** cell状态改变 */
@property(nonatomic, copy) void (^cellStyleChange)(void);

/** 获取选择的收货人信息 */
@property(nonatomic, copy) void (^consigneeINFO)(HEBLocationModel *model);

@end
