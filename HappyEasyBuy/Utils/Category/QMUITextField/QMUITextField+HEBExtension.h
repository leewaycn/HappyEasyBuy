//
//  QMUITextField+HEBExtension.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/5.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface QMUITextField (HEBExtension)

/** 小数点之后最大长度为两位 */
@property(nonatomic, assign) BOOL tail;

@end
