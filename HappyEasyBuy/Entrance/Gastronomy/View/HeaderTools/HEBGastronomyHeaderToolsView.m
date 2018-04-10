//
//  HEBGastronomyHeaderToolsView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/23.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBGastronomyHeaderToolsView.h"

@implementation HEBGastronomyHeaderToolsView

- (void)loadView {
    self.backgroundColor = UIColorWhite;
    NSArray<NSString *> *btnArr = @[@"全部 ", @"距离最近 "];
    __weak __typeof(self)weakSelf = self;
    [btnArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QMUIButton *sender = [[QMUIButton alloc] init];
        [sender addTarget:weakSelf action:@selector(senderDidClick:) forControlEvents:UIControlEventTouchUpInside];
        sender.tag = idx+100;
        [weakSelf addSubview:sender];
        [sender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.width.mas_offset(SCREEN_WIDTH/2);
            make.left.equalTo(weakSelf.mas_left).offset(idx*(SCREEN_WIDTH/2));
        }];
        [sender setImage:UIImageMake(@"选择") forState:UIControlStateNormal];
        [sender setTitle:obj forState:UIControlStateNormal];
        [sender setImagePosition:(QMUIButtonImagePositionRight)];
        [sender setTitleColor:BASEBLACK forState:UIControlStateNormal];
        sender.titleLabel.font = UIFontMake(16);
        if (idx==0) {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = UIColorHex(#e7e7e7);
            [weakSelf addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(weakSelf);
                make.width.mas_offset(@1);
                make.height.equalTo(weakSelf.mas_height).offset(-15);
            }];
        }
        [weakSelf.btnArrM addObject:sender];
    }];
}

- (void)senderDidClick:(QMUIButton *)sender {
    if (self.getHeaderToolsDidClick) {
        self.getHeaderToolsDidClick(sender.tag);
    }
}

- (NSMutableArray<QMUIButton *> *)btnArrM {
    if (!_btnArrM) {
        _btnArrM = [NSMutableArray array];
    }
    return _btnArrM;
}

@end
