//
//  HEBTakOutDetailShopActiveView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"
#import "HEBTakOutShopPicView.h"

@interface HEBTakOutShopActiveHeaderView : QMUIView

/** 拨打电话 */
@property(nonatomic, strong) QMUIButton *callPhone;

/** 地址 */
@property(nonatomic, strong) QMUIButton *address;

/** 商家图片 */
@property(nonatomic, strong) HEBTakOutShopPicView *shopPicView;

@end
