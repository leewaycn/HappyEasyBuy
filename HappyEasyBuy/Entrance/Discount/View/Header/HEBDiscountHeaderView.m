//
//  HEBDiscountHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBDiscountHeaderView.h"

@implementation HEBDiscountHeaderView

- (void)loadView {
    self.dividingLine = YES;
    NSArray <NSString *>*btnArr = @[@"通用优惠券", @"商家优惠券"];
    __weak __typeof(self)weakSelf = self;
    [btnArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QMUIButton *sender = [[QMUIButton alloc] init];
        [sender setTitle:obj forState:UIControlStateNormal>>UIControlStateSelected];
        [sender setTitleColor:BASEBLACK forState:UIControlStateNormal];
        [sender setTitleColor:BASECOLOR forState:UIControlStateSelected];
        sender.tag = idx+100;
        sender.selected = !idx;
        sender.userInteractionEnabled = idx;
        [sender addTarget:weakSelf action:@selector(senderDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [weakSelf addSubview:sender];
        [sender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.width.mas_offset(SCREEN_WIDTH/btnArr.count);
            make.left.equalTo(weakSelf.mas_left).offset(idx*(SCREEN_WIDTH/btnArr.count));
        }];
    }];
}

- (void)senderDidClick:(QMUIButton *)sender {
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    QMUIButton *btn = [self viewWithTag:sender.tag==100?101:100];
    btn.selected = NO;
    btn.userInteractionEnabled = YES;
    if (self.discountDidClick) {
        self.discountDidClick(sender.tag-100);
    }
}

@end
