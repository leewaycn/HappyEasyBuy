//
//  HEBHotSellView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/15.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"
#import "HEBHotSellModel.h"

@interface HEBHotSellView : QMUIView

/** 用于在外部设置商品图片 */
@property(nonatomic, strong) NSMutableArray<UIImageView *> *hotSellIMGArrM;

/** 热销商品数据源 */
@property(nonatomic, strong) NSArray<HEBHotSellModel *> *hotSellModelArr;

@end
