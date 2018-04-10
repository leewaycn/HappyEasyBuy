//
//  HEBOptimizationView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUICollectionView.h"
#import "HEBOptimizationModel.h"

@interface HEBOptimizationView : QMUICollectionView

/** 数据源 */
@property(nonatomic, strong) NSArray<HEBOptimizationModel *> *optimizationModelArr;

/** 获取优选商品点击事件 */
@property(nonatomic, copy) void (^getOptimizationDidClick)(HEBOptimizationModel *model);

@end
