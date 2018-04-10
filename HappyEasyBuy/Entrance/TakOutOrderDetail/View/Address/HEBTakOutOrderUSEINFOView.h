//
//  HEBTakOutOrderUSEINFOView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/15.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBTakOutOrderUSEINFOView : QMUIView

/** 收货地址 */
@property(nonatomic, strong) QMUILabel *address;

/** 收货人姓名 */
@property(nonatomic, strong) QMUILabel *userName;

/** 手机号 */
@property(nonatomic, strong) QMUILabel *mobNumber;

@end
