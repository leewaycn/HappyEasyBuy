//
//  HEBMessageView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/8.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBMessageModel.h"

@interface HEBMessageView : QMUITableView

@property(nonatomic, strong) NSMutableArray<HEBMessageModel *> *messageModelArrM;

@end
