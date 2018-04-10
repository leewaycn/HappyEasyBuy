//
//  HEBIntegratedMallOrderCell.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/18.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBIntegratedMallOrderCell : QMUITableViewCell

- (void)setCellINFO;

/** 标题 */
@property(nonatomic, strong) QMUILabel *title;

/** 选择信息 */
@property(nonatomic, strong) QMUIButton *selectINFO;

/** 用户信息 */
@property(nonatomic, strong) QMUITextField *infoField;

@end
