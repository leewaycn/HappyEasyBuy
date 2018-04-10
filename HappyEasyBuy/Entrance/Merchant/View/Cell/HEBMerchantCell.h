//
//  HEBMerchantCell.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBMerchantCell : QMUITableViewCell

- (void)setCellINFO;

/** icon */
@property(nonatomic, strong) UIImageView *img;

/** 文本 */
@property(nonatomic, strong) QMUITextField *field;

@end
