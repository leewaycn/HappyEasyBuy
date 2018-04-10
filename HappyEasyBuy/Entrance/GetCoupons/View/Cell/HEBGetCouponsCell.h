//
//  HEBGetCouponsCell.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBGetCouponsCell : QMUITableViewCell

- (void)setCell;

@property(nonatomic, strong) UIView *bgView;

/** 抵用价 */
@property(nonatomic, strong) QMUILabel *reduce;

/** 使用条件 */
@property(nonatomic, strong) QMUILabel *conditions;

/** 有效期 */
@property(nonatomic, strong) QMUILabel *aging;

/** 领取 */
@property(nonatomic, strong) QMUIButton *pickUp;

@end
