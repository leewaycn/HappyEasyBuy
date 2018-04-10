//
//  HEBAppraiseView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBPackageDetailsAppraiseModel.h"

@interface HEBAppraiseView : QMUITableView

@property(nonatomic, strong) NSMutableArray<HEBPackageDetailsAppraiseModel *> *allCommentsArrM;

@end
