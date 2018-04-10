//
//  HEBPayPasswordView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/3.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBPayPasswordHeaderView.h"

@interface HEBPayPasswordView : QMUITableView

@property(nonatomic, strong) HEBPayPasswordHeaderView *headerView;

@property(nonatomic, strong) NSArray<NSDictionary *> *cellModelArr;

/** 立即支付 */
@property(nonatomic, strong) QMUIButton *pay;

@end
