//
//  HEBPersonalTabView.h
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBPersonalTabView : QMUITableView

/** 用户修改头像 */
@property(nonatomic, copy) void (^UserHeaderChange)(UIImage *header);

/** 用户修改昵称 */
@property(nonatomic, copy) void (^UserNickNameChange)(NSString *nickName);

@end
