//
//  HEBOrderHotelDetailView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBOrderHotelDetailModel.h"
#import "HEBOrderHotelDetailHeaderView.h"

@interface HEBOrderHotelDetailView : QMUITableView

@property(nonatomic, strong) HEBOrderHotelDetailHeaderView *headerView;

@property(nonatomic, strong) HEBOrderHotelDetailModel *hotelModel;

@end
