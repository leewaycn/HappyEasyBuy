//
//  HEBPaySuccessView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/4.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBPaySuccessHeaderView.h"

@interface HEBPaySuccessView : QMUITableView

@property(nonatomic, strong) HEBPaySuccessHeaderView *headerView;

@property(nonatomic, strong) NSArray<NSDictionary *> *cellModelArr;

@end
