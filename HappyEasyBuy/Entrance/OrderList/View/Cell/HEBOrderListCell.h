//
//  HEBOrderListCell.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/19.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBOrderListCell : QMUITableViewCell

/** 商品图 */
@property(nonatomic, strong) UIImageView *icon;

/** 商品名称 */
@property(nonatomic, strong) QMUILabel *name;

/** 时间 */
@property(nonatomic, strong) QMUILabel *time;

/** 金额 */
@property(nonatomic, strong) QMUILabel *money;

/** 订单状态 */
@property(nonatomic, strong) QMUIButton *status;

- (void)setCellINFO;

@end
