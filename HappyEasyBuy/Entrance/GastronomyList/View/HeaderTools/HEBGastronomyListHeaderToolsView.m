//
//  HEBHeaderToolsView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/24.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBGastronomyListHeaderToolsView.h"

@interface HEBGastronomyListHeaderToolsView ()

/** 暂存筛选类目 */
@property(nonatomic, strong) NSMutableArray <QMUIButton *>*senderArrM;

@end

@implementation HEBGastronomyListHeaderToolsView

- (void)loadView {
    self.qmui_borderWidth = 1.f;
    self.qmui_borderColor = UIColorHex(#e7e7e7);
    self.qmui_borderPosition = QMUIBorderViewPositionTop;
    NSArray <NSString *>*btnNameArr = @[@"距离最近", @"价格最低", @"好评优先"];
    __weak __typeof(self)weakSelf = self;
    [btnNameArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QMUIButton *sender = [[QMUIButton alloc] init];
        sender.tag = idx;
        [sender setTitle:obj forState:UIControlStateNormal>>UIControlStateDisabled];
        [sender setTitleColor:BASEBLACK forState:UIControlStateNormal];
        [sender setTitleColor:BASECOLOR forState:UIControlStateDisabled];
        [sender addTarget:weakSelf action:@selector(senderDidClick:) forControlEvents:UIControlEventTouchUpInside];
        if (idx == 1) {
            sender.enabled = NO;
        }
        [weakSelf addSubview:sender];
        [sender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.width.mas_offset(SCREEN_WIDTH/3);
            make.left.equalTo(weakSelf.mas_left).offset(idx*(SCREEN_WIDTH/3));
        }];
        if (idx != 2) {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = UIColorHex(#e7e7e7);
            [weakSelf addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(sender.mas_right);
                make.width.mas_offset(@1);
                make.top.equalTo(sender.mas_top).offset(5);
                make.bottom.equalTo(sender.mas_bottom).offset(-5);
            }];
        }
        [weakSelf.senderArrM addObject:sender];
    }];
}

- (void)senderDidClick:(QMUIButton *)sender {
    [self.senderArrM enumerateObjectsUsingBlock:^(QMUIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == sender.tag) {
            obj.enabled = NO;
        }else {
            obj.enabled = YES;
        }
    }];
    if (self.getHeaderToolsDidClick) {
        self.getHeaderToolsDidClick(sender.tag);
    }
}

- (NSMutableArray<QMUIButton *> *)senderArrM {
    if (!_senderArrM) {
        _senderArrM = [NSMutableArray array];
    }
    return _senderArrM;
}

@end
