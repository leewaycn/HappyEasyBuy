//
//  HEBTakOutSendTimeView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutSendTimeView.h"

@implementation HEBTakOutSendTimeView

- (void)loadView {
    UIImageView *img = [[UIImageView alloc] initWithImage:UIImageMake(@"外卖_配送时间")];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(15);
        make.size.mas_offset(img.image.size);
    }];
    
    QMUILabel *sendTime = [[QMUILabel alloc] init];
    selfClass(sendTime);
    sendTime.font = UIFontMake(14);
    [self addSubview:sendTime];
    [sendTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img.mas_right).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(img.mas_centerY);
    }];
}

@end
