//
//  HEBLocationCell.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/26.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBLocationCell : QMUITableViewCell

- (void)setCellINFO;

/** 收获地址 */
@property(nonatomic, strong) QMUILabel *address;

/** 收货人信息 */
@property(nonatomic, strong) QMUILabel *userINFO;

@end
