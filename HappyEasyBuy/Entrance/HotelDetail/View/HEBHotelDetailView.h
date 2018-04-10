//
//  HEBHotelDetailView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBHotelDetailHeaderView.h"
#import "HEBGetCouponsModel.h"
#import "HEBHotelRoomModel.h"

@interface HEBHotelDetailView : QMUITableView

@property(nonatomic, strong) NSArray<HEBGetCouponsModel *> *couponsModelArr;

@property(nonatomic, strong) NSArray<HEBHotelRoomModel *> *roomModelArr;

@property(nonatomic, strong) HEBHotelDetailHeaderView *headerView;
/** 酒店id */
@property(nonatomic, copy) NSString *hotelid;

@end
