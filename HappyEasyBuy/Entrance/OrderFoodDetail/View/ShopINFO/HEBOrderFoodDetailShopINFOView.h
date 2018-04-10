//
//  HEBOrderFoodDetailShopINFOView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBOrderFoodDetailShopINFOView : QMUIView

/** 店名 */
@property(nonatomic, strong) QMUILabel *shopName;

/** 拨打店铺电话 */
@property(nonatomic, strong) QMUIButton *callPhone;

/** 地图 */
@property(nonatomic, strong) QMUIButton *map;

/** 地址 */
@property(nonatomic, strong) QMUILabel *address;

@end
