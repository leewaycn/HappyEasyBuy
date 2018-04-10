//
//  HEBShippingAddressView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/27.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBShippingAddressView : QMUIView

/** 姓名 */
@property(nonatomic, strong) QMUITextField *userName;

/** 手机号 */
@property(nonatomic, strong) QMUITextField *mobNumber;

/** 省市区 */
@property(nonatomic, strong) QMUITextField *location;

/** 详细地址 */
@property(nonatomic, strong) QMUITextView *address;

@end
