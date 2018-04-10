//
//  HEBTakOutSKUView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/9.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"
#import "HEBTakOutDetailModel.h"

@interface HEBTakOutSKUView : QMUIView

/** sku数据模型 */
@property(nonatomic, strong) NSArray<HEBTakOutSKUModel *> *skuModelArr;

/** sku数据模型修改 */
@property(nonatomic, copy) void (^SKUModelArrChange)(NSArray<HEBTakOutSKUModel *> *skuModelArr, NSInteger idx, NSInteger count, NSString *sku);

- (void)loadAlertView;

@end
