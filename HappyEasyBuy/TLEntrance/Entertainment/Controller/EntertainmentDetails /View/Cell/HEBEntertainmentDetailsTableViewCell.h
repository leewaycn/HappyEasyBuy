//
//  HEBEntertainmentDetailsTableViewCell.h
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/26.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HEBEntertainmentDetailsTableViewCell : UITableViewCell

-(void)setCellINFO;

/** icon */
@property(nonatomic, strong) UIImageView *iconImage;

/** 套餐名称 */
@property(nonatomic, strong) QMUILabel *nameLabel;

/** 价格 */
@property(nonatomic, strong)  QMUILabel *pricLabel;

/** 已售 */
@property(nonatomic, strong) QMUILabel *sellLabe;

@end
