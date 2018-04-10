//
//  HEBPersonInformationVc.h
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"

@interface HEBPersonInformationVc : HEBBaseViewController

/** 用户修改头像的事件传递 */
@property(nonatomic, copy) void (^UserHeaderChange)(UIImage *header);

/** 用户修改昵称的事件传递 */
@property(nonatomic, copy) void (^UserNickNameChange)(NSString *nickName);

/** 用户修改密码的事件传递 */
@property(nonatomic, copy) void (^UserPassword)(NSString *password);

@end
