//
//  HEBOrderListView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/19.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBOrderListModel.h"

@interface HEBOrderListView : QMUITableView

/** 订单列表数据源 */
@property(nonatomic, strong) NSMutableArray<HEBOrderListModel *> *orderlistArrM;

/** 是否为虚拟商品 */
@property(nonatomic, assign) BOOL isVirtual;

@end
