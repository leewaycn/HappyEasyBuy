//
//  HEBShopINFOView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBPackageDetailsShopINFOView : QMUIView

/** 拨打按钮 */
@property(nonatomic, strong) QMUIButton *callPhone;

/** 商家名称 */
@property(nonatomic, strong) QMUILabel *shopName;

/** 商家地址 */
@property(nonatomic, strong) QMUILabel *address;

/** 距离 */
@property(nonatomic, strong) QMUILabel *distance;

@end
