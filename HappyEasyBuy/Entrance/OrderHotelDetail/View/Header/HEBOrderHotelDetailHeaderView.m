//
//  HEBOrderHotelDetailHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderHotelDetailHeaderView.h"

@implementation HEBOrderHotelDetailHeaderView

- (void)loadView {
    self.dividingLine = YES;
    QMUILabel *msg = [[QMUILabel alloc] init];
    selfClass(msg);
    msg.font = UIFontMake(22);
    msg.textColor = UIColorWhite;
    [self addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

@end
