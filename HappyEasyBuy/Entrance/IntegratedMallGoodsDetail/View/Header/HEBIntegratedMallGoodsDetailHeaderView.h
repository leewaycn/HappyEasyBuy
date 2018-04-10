//
//  HEBIntegratedMallGoodsDetailHeaderView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"
#import "HEBIntegratedMallGoodsDetailModel.h"

@interface HEBIntegratedMallGoodsDetailHeaderView : QMUIView

/** 商品图片 */
@property(nonatomic, strong) UIImageView *icon;

/** 商品名称 */
@property(nonatomic, strong) QMUILabel *name;

@end
