//
//  HEBFinanceCell.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HEBFinanceCell : QMUITableViewCell

- (void)setCellINFO;

/** 百分比 */
@property(nonatomic, strong) QMUILabel *percentage;

/** 二级百分比 */
@property(nonatomic, strong) QMUILabel *SPercentage;

/** 描述 */
@property(nonatomic, strong) QMUILabel *describe;

/** 二级描述 */
@property(nonatomic, strong) QMUILabel *SDescribe;

@end
