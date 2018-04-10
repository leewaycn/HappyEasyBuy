//
//  HEBBalanceRecordView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/11.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBBalanceRecordModel.h"

@interface HEBBalanceRecordView : QMUITableView

@property(nonatomic, strong) NSMutableArray<HEBBalanceRecordModel *> *recordModelArr;

@end
