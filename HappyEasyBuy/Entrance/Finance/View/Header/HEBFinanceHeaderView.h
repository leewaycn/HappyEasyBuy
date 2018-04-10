//
//  HEBFinanceHeaderView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBFinanceHeaderView : QMUIView

/** 昨日收益 */
@property(nonatomic, strong) QMUILabel *earningsYD;

/** 总金额 */
@property(nonatomic, strong) QMUILabel *allMoney;

/** 0:固定收益；1:即时收益 */
@property(nonatomic, strong) NSMutableArray<QMUILabel *> *earnings;

@end
