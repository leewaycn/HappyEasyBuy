//
//  HEBIntegratedMallOrderView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/18.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBIntegratedMallOrderHeaderView.h"

@interface HEBIntegratedMallOrderView : QMUITableView

@property(nonatomic, strong) HEBIntegratedMallOrderHeaderView *headerView;

/** 积分 */
@property(nonatomic, copy) NSString *integral;

/** 是否为实物 */
@property(nonatomic, assign) BOOL isReal;

@end
