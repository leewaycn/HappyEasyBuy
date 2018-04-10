//
//  HEBIntegratedMallGoodsDetailView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBIntegratedMallGoodsDetailHeaderView.h"
#import <YYLabel.h>


@interface HEBIntegratedMallGoodsDetailView : QMUITableView

@property(nonatomic, strong) HEBIntegratedMallGoodsDetailHeaderView *headerView;

@property(nonatomic, strong) HEBIntegratedMallGoodsDetailModel *model;

@end
