//
//  HEBPostCommentsView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/19.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"
#import "RatingBar.h"

@interface HEBPostCommentsView : QMUIView

/** 星级评分 */
@property(nonatomic, strong) RatingBar *star;

/** 评价内容 */
@property(nonatomic, strong) QMUITextView *comment;

/** 图片数组 */
@property(nonatomic, strong) NSMutableArray<UIImage *> *imgs;

@end
