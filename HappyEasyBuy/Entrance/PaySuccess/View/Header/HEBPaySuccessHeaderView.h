//
//  HEBPaySuccessView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/4.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBPaySuccessHeaderView : QMUIView

/** 成功的图片 */
@property(nonatomic, strong) UIImageView *successImg;

/** 花费的费用 */
@property(nonatomic, strong) QMUILabel *money;

/** 成功的提示文字 */
@property(nonatomic, strong) QMUILabel *successMsg;

/** 因某些特殊要求，可以使用此参数 */
@property(nonatomic, strong) QMUILabel *msg;

@end
