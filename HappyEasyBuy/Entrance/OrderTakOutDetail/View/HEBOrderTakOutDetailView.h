//
//  HEBOrderTakOutDetailView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBOrderHotelDetailHeaderView.h"
#import "HEBOrderTakOutDetailModel.h"

@interface HEBOrderTakOutDetailView : QMUITableView

@property(nonatomic, strong) HEBOrderHotelDetailHeaderView *headerView;

@property(nonatomic, strong) HEBOrderTakOutDetailModel *takeoutmodel;

@end
