//
//  HEBHEBHappyMoneyTopupRecordCell.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/10.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBHappyMoneyTopupRecordCell : QMUITableViewCell

- (void)setCellINFO;

/** 订单号 */
@property(nonatomic, strong) QMUILabel *order;

/** 类型 */
@property(nonatomic, strong)  QMUILabel *type;

/** 增加金额 */
@property(nonatomic, strong) QMUILabel *money;

/** 时间 */
@property(nonatomic, strong) QMUILabel *time;

/** 支付方式 */
@property(nonatomic, strong) QMUILabel *payMoney;

@end
