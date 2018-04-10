//
//  HEBShopActiveView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBTakOutShopActiveHeaderView.h"
#import "HEBTakOutShopActiveINFOModel.h"

@interface HEBShopActiveView : QMUITableView

/** 头部视图 */
@property(nonatomic, strong) HEBTakOutShopActiveHeaderView *headerView;

/** 外卖店铺信息 */
@property(nonatomic, strong) NSArray<NSArray<NSDictionary *> *> *shopINFOArr;

@property(nonatomic, copy) void (^getCoupon)(BOOL isDidClick);

@end
