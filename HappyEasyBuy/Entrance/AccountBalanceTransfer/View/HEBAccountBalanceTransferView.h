//
//  HEBAccountBalanceTransferView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/11.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBAccountBalanceTransferView : QMUITableView

@property(nonatomic, copy) void (^getPayType)(NSInteger payType, NSString *money, NSString *user);

@end
