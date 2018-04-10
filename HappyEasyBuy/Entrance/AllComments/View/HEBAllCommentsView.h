//
//  HEBAllCommentsView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBPackageDetailsAppraiseModel.h"

@interface HEBAllCommentsView : QMUITableView

/** 评论数据源 */
@property(nonatomic, strong) NSMutableArray<HEBPackageDetailsAppraiseModel *> *cellModelArrM;

@end
