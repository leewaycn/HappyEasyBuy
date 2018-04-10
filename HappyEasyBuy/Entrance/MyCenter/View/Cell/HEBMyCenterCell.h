//
//  HEBMyCenterCell.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/27.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBMyCenterCell : QMUITableViewCell

- (void)setCellINFO;

@property(nonatomic, strong) UIImageView *img;

@property(nonatomic, strong) QMUILabel *title;

@end
