//
//  HEBRegisterView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBRegisterView : QMUIView

/** 手机号 */
@property(nonatomic, strong) QMUITextField *mobNumber;

/** 获取验证码 */
@property(nonatomic, strong) QMUIButton *sendMsg;

/** 验证码 */
@property(nonatomic, strong) QMUITextField *verification;

/** 登录密码 */
@property(nonatomic, strong) QMUITextField *loginPassword;

/** 支付密码 */
@property(nonatomic, strong) QMUITextField *payPassword;

@end
