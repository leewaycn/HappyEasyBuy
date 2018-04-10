//
//  HEBPackageDetailsAppraiseView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"
#import "RatingBar.h"
#import <YYLabel.h>

@interface HEBPackageDetailsAppraiseView : QMUIView

/** 用户头像 */
@property(nonatomic, strong) UIImageView *header;

/** 用户名 */
@property(nonatomic, strong) QMUILabel *userName;

/** 评论时间 */
@property(nonatomic, strong) QMUILabel *time;

/** 评分 */
@property(nonatomic, strong) RatingBar *start;

/** 评论内容 */
@property(nonatomic, strong) QMUILabel *msg;

/** 图片评论 */
@property(nonatomic, strong) NSMutableArray<UIImageView *> *imgArrM;

/** 商家回复提示 */
@property(nonatomic, strong) YYLabel *respond;

/** 商家回复内容 */
@property(nonatomic, strong) QMUILabel *shopMsg;

@property(nonatomic, strong) UIView *bg;

@end
