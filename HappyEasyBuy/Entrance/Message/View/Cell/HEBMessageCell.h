//
//  HEBMessageCell.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/8.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBMessageCell : QMUITableViewCell

- (void)setCellINFO;

/** 标题 */
@property(nonatomic, strong) QMUILabel *title;

/** 内容 */
@property(nonatomic, strong) QMUILabel *content;

/** 时间 */
@property(nonatomic, strong) QMUILabel *time;

@end
