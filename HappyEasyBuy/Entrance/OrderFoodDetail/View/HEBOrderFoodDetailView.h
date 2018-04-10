//
//  HEBOrderFoodDetailView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBOrderFoodDetailHeaderView.h"
#import "HEBOrderFoodDetailModel.h"

@interface HEBOrderFoodDetailView : QMUITableView

/** 顶部商品信息 */
@property(nonatomic, strong) HEBOrderFoodDetailHeaderView *headerView;

@property(nonatomic, strong) HEBOrderFoodDetailModel *orderModel;

@end
