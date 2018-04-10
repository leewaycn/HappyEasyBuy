//
//  HEBEntertainmentDetailsView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/3.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBEntertainmentDetailsListModel.h"
#import "HEBEntertainmentDetailsModel.h"

@interface HEBEntertainmentDetailsView : QMUITableView

@property(nonatomic, strong) NSArray<HEBEntertainmentDetailsListModel *> *cellModelArr;
@property(nonatomic, strong)HEBEntertainmentDetailsModel *entertainmentDetailsModel;

@end
