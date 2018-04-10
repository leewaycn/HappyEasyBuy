//
//  HEBFinanceView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBFinanceHeaderView.h"
#import "HEBFinanceModel.h"

@interface HEBFinanceView : QMUITableView

@property(nonatomic, strong) HEBFinanceHeaderView *headerView;

@property(nonatomic, strong) NSMutableArray<HEBFinanceModel *> *financeModelArrM;

@end
