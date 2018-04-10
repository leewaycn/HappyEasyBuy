//
//  HEBTakOutDetailToolsView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/9.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutDetailToolsView.h"

@interface HEBTakOutDetailToolsView ()

@property(nonatomic, strong) NSMutableArray<QMUIButton *> *toolsArrM;

@property(nonatomic, strong) UIView *line;

@end

@implementation HEBTakOutDetailToolsView

- (void)loadView {
    self.bottomLine = YES;
    NSArray <NSString *> *toolsArr = @[@"点菜", @"评价", @"商家"];
    __weak __typeof(self)weakSelf = self;
    [toolsArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QMUIButton *tools = [[QMUIButton alloc] init];
        tools.tag = idx;
        [tools setTitle:obj forState:UIControlStateNormal>>UIControlStateDisabled];
        [tools setTitleColor:BASEBLACK forState:UIControlStateNormal];
        [tools setTitleColor:BASECOLOR forState:UIControlStateDisabled];
        [tools addTarget:weakSelf action:@selector(toolsDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [weakSelf addSubview:tools];
        [tools mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.mas_left).offset(idx*(SCREEN_WIDTH/toolsArr.count));
            make.width.mas_offset(SCREEN_WIDTH/toolsArr.count);
        }];
        tools.enabled = idx==0?NO:YES;
        [weakSelf.toolsArrM addObject:tools];
    }];
    UIView *line = [[UIView alloc] init];
    selfClass(line);
    line.backgroundColor = BASECOLOR;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.mas_offset(3);
        make.width.mas_offset(SCREEN_WIDTH/3/4);
        make.centerX.equalTo(self.toolsArrM.firstObject.mas_centerX);
    }];
}

- (void)toolsDidClick:(QMUIButton *)sender {
    [self.toolsArrM enumerateObjectsUsingBlock:^(QMUIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == sender.tag) {
            obj.enabled = NO;
        }else {
            obj.enabled = YES;
        }
    }];
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
      weakSelf.line.centerX = sender.centerX;
    }];
    if (self.getTakOutToolsDidClick) {
        self.getTakOutToolsDidClick(sender.tag);
    }
}


- (NSMutableArray<QMUIButton *> *)toolsArrM {
    if (!_toolsArrM) {
        _toolsArrM = [NSMutableArray array];
    }
    return _toolsArrM;
}

@end
