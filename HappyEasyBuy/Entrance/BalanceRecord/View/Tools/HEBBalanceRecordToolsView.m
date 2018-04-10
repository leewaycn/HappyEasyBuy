//
//  HEBBalanceRecordToolsView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/11.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBBalanceRecordToolsView.h"

@interface HEBBalanceRecordToolsView ()

@property(nonatomic, strong) NSMutableArray<QMUIButton *> *toolsArrM;

@end

@implementation HEBBalanceRecordToolsView

- (void)loadView {
    self.dividingLine = YES;
    NSArray <NSString *> *toolsArr = @[@"充值", @"提现", @"转账"];
    weakOBJ(self);
    [toolsArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QMUIButton *sender = [[QMUIButton alloc] init];
        sender.tag = 100+idx;
        sender.selected = !idx;
        sender.userInteractionEnabled = idx;
        [sender setTitle:obj forState:UIControlStateNormal>>UIControlStateSelected];
        [sender setTitleColor:BASECOLOR forState:UIControlStateSelected];
        [sender setTitleColor:BASEBLACK forState:UIControlStateNormal];
        [sender addTarget:weak_self action:@selector(senderDidClick:) forControlEvents:UIControlEventTouchUpInside];
        sender.titleLabel.font = UIFontMake(16);
        [weak_self addSubview:sender];
        [sender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weak_self);
            make.width.mas_offset(SCREEN_WIDTH/toolsArr.count);
            make.left.equalTo(weak_self.mas_left).offset(idx*(SCREEN_WIDTH/toolsArr.count));
        }];
        [weak_self.toolsArrM addObject:sender];
    }];
}

- (void)senderDidClick:(QMUIButton *)sender {
    sender.userInteractionEnabled = NO;
    sender.selected = YES;
    [self.toolsArrM enumerateObjectsUsingBlock:^(QMUIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag != sender.tag) {
            obj.selected = NO;
            obj.userInteractionEnabled = YES;
        }
    }];
    if (self.senderDidClick) {
        self.senderDidClick(sender.tag-100);
    }
}

- (NSMutableArray<QMUIButton *> *)toolsArrM {
    if (!_toolsArrM) {
        _toolsArrM = [NSMutableArray array];
    }
    return _toolsArrM;
}

@end
