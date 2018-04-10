//
//  HEBFilteringRulesView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/23.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBClassificationModel.h"

@interface HEBFilteringRulesView : QMUITableView

/** 网络获取的筛选信息 */
@property(nonatomic, strong) NSArray<NSDictionary *> *netWorkingModelArr;

/** 本地筛选信息 */
@property(nonatomic, strong) NSArray<NSDictionary *> *localModelArr;

/** 获取选择的类目 */
@property(nonatomic, copy) void (^getHeaderToolsDidClick)(NSArray *dataArr, NSInteger idx, NSString *name);

@end
