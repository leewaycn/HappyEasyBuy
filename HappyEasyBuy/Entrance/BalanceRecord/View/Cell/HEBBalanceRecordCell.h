//
//  HEBBalanceRecordCell.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/11.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBBalanceRecordCell : QMUITableViewCell

/** 订单信息 */
@property(nonatomic, strong) QMUILabel *order;

/** 金额 */
@property(nonatomic, strong) QMUILabel *money;

/** 时间 */
@property(nonatomic, strong) QMUILabel *time;

/** 支付方式 */
@property(nonatomic, strong) QMUILabel *pay;

- (void)setCellINFO;

@end
