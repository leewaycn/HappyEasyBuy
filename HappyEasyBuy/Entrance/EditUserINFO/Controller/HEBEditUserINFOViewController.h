//
//  HEBEditUserINFOViewController.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/6.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBEditUserINFOViewController : HEBBaseViewController

/** 用户默认信息 */
@property(nonatomic, copy) NSString *userNormal;

/** 用户修改昵称 */
@property(nonatomic, copy) void (^NickNameChange)(NSString *nickName);

/** 用户修改手机号 */
@property(nonatomic, copy) void (^MobNumberChange)(NSString *mobNumber);

/** 用户修改密码 */
@property(nonatomic, copy) void (^PasswordChange)(NSString *password);

@end
