//
//  HEBFeedBackView.h
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBFeedBackView : QMUIView

/** 反馈内容 */
@property(nonatomic, strong) QMUITextView *feedBackText;

/** 手机号 */
@property(nonatomic, strong) QMUITextField *mobNumber;

/** 提交 */
@property(nonatomic, strong) QMUIButton *submit;

@end
