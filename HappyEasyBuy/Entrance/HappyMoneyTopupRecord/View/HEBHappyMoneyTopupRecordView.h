//
//  HEBHappyMoneyTopupRecordView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/10.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBHappyMoneyTopupRecordModel.h"

@interface HEBHappyMoneyTopupRecordView : QMUITableView

@property(nonatomic, strong) NSMutableArray<HEBHappyMoneyTopupRecordModel *> *recordModelArr;

@end
