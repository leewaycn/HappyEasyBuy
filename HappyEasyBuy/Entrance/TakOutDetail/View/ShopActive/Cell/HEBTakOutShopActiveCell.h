//
//  HEBTakOutShopActiveCell.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBTakOutShopActiveCell : QMUITableViewCell

/** 图片 */
@property(nonatomic, strong) UIImageView *icon;

/** 标题 */
@property(nonatomic, strong) QMUILabel *name;

- (void)setCellINFO;

@end
