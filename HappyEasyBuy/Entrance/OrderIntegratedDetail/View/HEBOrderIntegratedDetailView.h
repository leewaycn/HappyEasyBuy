//
//  HEBOrderIntegratedDetailView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBOrderIntegratedDetailHeaderView.h"
#import "HEBOrderIntegratedDetailModel.h"

@interface HEBOrderIntegratedDetailView : QMUITableView

@property(nonatomic, strong) HEBOrderIntegratedDetailHeaderView *headerView;

@property(nonatomic, strong) HEBOrderIntegratedDetailModel *integratedModel;

@end
