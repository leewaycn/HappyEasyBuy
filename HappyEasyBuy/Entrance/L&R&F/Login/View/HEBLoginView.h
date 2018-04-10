//
//  HEBLoginView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBLoginView : QMUIView

/** 手机号 */
@property(nonatomic, strong) QMUITextField *phoneTextField;

/** 密码 */
@property(nonatomic, strong) QMUITextField *codeTextField;

/** 登录按钮 */
@property(nonatomic, strong) QMUIButton *logInBtn;

@end
