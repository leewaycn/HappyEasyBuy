//
//  HEBFinanceDetailView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBCycleScrollView.h"
#import "HEBFinanceDetailMdoel.h"

@interface HEBFinanceDetailView : QMUITableView

@property(nonatomic, strong) HEBCycleScrollView *headerView;

@property(nonatomic, strong) HEBFinanceDetailMdoel *model;

@end
