//
//  HEBEditUserINFOView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/6.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBEditUserINFOView : QMUIView

/** 默认用户信息 */
@property(nonatomic, strong) QMUILabel *userNormal;

/** 昵称 */
@property(nonatomic, strong) QMUITextField *nickName;

/** 手机号 */
@property(nonatomic, strong) QMUITextField *mobNumber;

/** 验证码 */
@property(nonatomic, strong) QMUITextField *verification;

/** verify表的id */
@property(nonatomic, copy) NSString *objid;

/** 旧密码 */
@property(nonatomic, strong) QMUITextField *oldPassword;

/** 新密码 */
@property(nonatomic, strong) QMUITextField *password1;

/** 新密码 */
@property(nonatomic, strong) QMUITextField *password2;

/** 加载昵称 */
- (void)loadNickName;

/** 加载手机号 */
- (void)loadMobNumber;

/** 加载密码 */
- (void)loadPassword;

/** 忘记支付密码 */
- (void)loadForgetPayPass;

@end
