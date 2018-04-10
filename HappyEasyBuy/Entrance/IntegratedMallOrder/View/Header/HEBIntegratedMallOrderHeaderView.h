//
//  HEBIntegratedMallOrderHeaderView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/18.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBIntegratedMallOrderHeaderView : QMUIView

/** 商品图 */
@property(nonatomic, strong) UIImageView *icon;

/** 商品名称 */
@property(nonatomic, strong) QMUILabel *name;

/** 商品数量 */
@property(nonatomic, strong) QMUILabel *count;

/** 所需积分 */
@property(nonatomic, strong) QMUILabel *integral;

@end
