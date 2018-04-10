//
//  HEBMyCenterView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/27.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBMyCenterHeaderView.h"

@interface HEBMyCenterView : QMUITableView

/** 顶部视图 */
@property(nonatomic, strong) HEBMyCenterHeaderView *headerView;

@end
