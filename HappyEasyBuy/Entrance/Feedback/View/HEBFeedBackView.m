//
//  HEBFeedBackView.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBFeedBackView.h"

@implementation HEBFeedBackView

- (void)loadView {
    self.dividingLine = YES;
    QMUITextView *feedBackText = [[QMUITextView alloc] init];
    selfClass(feedBackText);
    feedBackText.placeholder = @"请留下您的求助信息，我们将及时与您联系！";
    feedBackText.backgroundColor = UIColorHex(#f1f1f1);
    feedBackText.font = UIFontMake(16);
    [self addSubview:feedBackText];
    [feedBackText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.equalTo(self.mas_left).offset(25);
        make.right.equalTo(self.mas_right).offset(-25);
        make.height.equalTo(self.mas_width).multipliedBy(0.4);
    }];
    feedBackText.layer.cornerRadius = 5;
    feedBackText.layer.borderColor = UIColorHex(#e7e7e7).CGColor;
    feedBackText.layer.borderWidth = 1;
    feedBackText.layer.masksToBounds = YES;
    
    QMUITextField *mobNumber = [[QMUITextField alloc] init];
    selfClass(mobNumber);
    mobNumber.placeholder = @"请留下手机号码，以便我们回复您";
    mobNumber.font = UIFontMake(16);
    mobNumber.backgroundColor = UIColorHex(#f1f1f1);
    [self addSubview:mobNumber];
    [mobNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(feedBackText.mas_bottom).offset(10);
        make.left.right.equalTo(feedBackText);
        make.height.mas_offset(44);
    }];
    mobNumber.layer.cornerRadius = 5;
    mobNumber.layer.borderColor = UIColorHex(#e7e7e7).CGColor;
    mobNumber.layer.borderWidth = 1;
    mobNumber.layer.masksToBounds = YES;
    
    QMUIButton *submit = [[QMUIButton alloc] init];
    selfClass(submit);
    submit.backgroundColor = BASECOLOR;
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    [submit setTitleColor:UIColorWhite forState:UIControlStateNormal];
    [self addSubview:submit];
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(mobNumber);
        make.top.equalTo(mobNumber.mas_bottom).offset(20);
        make.height.mas_offset(44);
    }];
    submit.layer.cornerRadius = 5;
    submit.layer.masksToBounds = YES;
    
}

@end
