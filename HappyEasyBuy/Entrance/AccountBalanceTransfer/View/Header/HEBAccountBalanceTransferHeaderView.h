//
//  HEBAccountBalanceTransferHeaderView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/11.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBAccountBalanceTransferHeaderView : QMUIView

/** 验证用户是否存在 */
@property(nonatomic, strong) QMUIButton *validation;

/** 用户账号 */
@property(nonatomic, strong) QMUITextField *mobNumber;

@end
