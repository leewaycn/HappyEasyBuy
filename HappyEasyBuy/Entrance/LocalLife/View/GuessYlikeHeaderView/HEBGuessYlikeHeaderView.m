//
//  HEBGuessYlikeHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBGuessYlikeHeaderView.h"

@implementation HEBGuessYlikeHeaderView

- (void)loadHeaderView {
    self.backgroundColor = UIColorWhite;
    QMUILabel *lab = [[QMUILabel alloc] init];
    lab.text = self.lab;
    lab.font = UIFontMake(14);
    [self addSubview:lab];
    lab.top = 8;
    [lab sizeToFit];
    lab.centerX = SCREEN_WIDTH*0.5;
    
    UIView *leftLine = [[UIView alloc] init];
    leftLine.backgroundColor = UIColorBlack;
    [self addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab.mas_centerY);
        make.right.equalTo(lab.mas_left).offset(-4);
        make.size.mas_offset(CGSizeMake(25, 1));
    }];
    
    UIView *rightLine = [[UIView alloc] init];
    rightLine.backgroundColor = UIColorBlack;
    [self addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab.mas_centerY);
        make.size.equalTo(leftLine);
        make.left.equalTo(lab.mas_right).offset(4);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorHex(#e7e7e7);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab.mas_bottom).offset(8);
        make.left.right.equalTo(self);
        make.height.mas_offset(1);
    }];
    
    NSArray <NSDictionary *> *btnMsgArr = @[@{@"msg":[NSString stringWithFormat:@"%@ ", self.sequencingMsg?self.sequencingMsg:@"综合排序"], @"img":@"选择"},
                                            @{@"msg":@"销量最高"},
                                            @{@"msg":@"距离最近"},
                                            @{@"msg":@"筛选", @"img":@"筛选"}];
    for (int i = 0; i < btnMsgArr.count; i ++) {
        QMUIButton *btn = [[QMUIButton alloc] init];
        btn.tag = i+100;
        if ([[btnMsgArr[i] allKeys] containsObject:@"img"]) {
            [btn setTitle:btnMsgArr[i][@"msg"] forState:UIControlStateNormal];
            [btn setImage:UIImageMake(btnMsgArr[i][@"img"]) forState:UIControlStateNormal];
            btn.imagePosition = QMUIButtonImagePositionRight;
        }else {
            [btn setTitle:btnMsgArr[i][@"msg"] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(guessYlikeHeaderViewDidClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = UIFontMake(16);
        [btn setTitleColor:UIColorBlack forState:UIControlStateNormal];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom);
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left).offset(i*(SCREEN_WIDTH/4));
            make.width.mas_offset(SCREEN_WIDTH/4);
        }];
        [self.btnArrM addObject:btn];
    }
    
}

- (void)guessYlikeHeaderViewDidClick:(QMUIButton *)sender {
    if (self.guessYlikeHeaderViewDidClick) {
        self.guessYlikeHeaderViewDidClick(sender);
    }
}

- (NSMutableArray<QMUIButton *> *)btnArrM {
    if (!_btnArrM) {
        _btnArrM = [NSMutableArray array];
    }
    return _btnArrM;
}

@end
