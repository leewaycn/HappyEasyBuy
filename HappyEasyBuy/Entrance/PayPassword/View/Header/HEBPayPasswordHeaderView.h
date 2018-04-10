//
//  HEBPayPasswordView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/3.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBPayPasswordHeaderView : QMUIView

/** 支付密码 */
@property(nonatomic, strong) QMUITextField *payPass;

/** 支付金额 */
@property(nonatomic, strong) QMUILabel *money;

@end
