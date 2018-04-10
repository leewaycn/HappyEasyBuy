//
//  HEBOrderIntegratedDetailHeaderView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBOrderIntegratedDetailHeaderView : QMUIView

/** 当前状态 */
@property(nonatomic, strong) QMUILabel *status;

/** 送达时间 */
@property(nonatomic, strong) QMUILabel *time;

/** 订单号 */
@property(nonatomic, strong) QMUILabel *orderNum;

/** 图片 */
@property(nonatomic, strong) UIImageView *icon;

@end
