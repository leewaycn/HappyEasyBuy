//
//  HEBHotSellView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/15.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBHotSellView.h"
#import "HEBTakOutDetailViewController.h"

@implementation HEBHotSellView

- (void)loadView {
    QMUILabel *lab = [[QMUILabel alloc] init];
    lab.text = @"热销专区";
    lab.font = UIFontMake(14);
    [self addSubview:lab];
    lab.top = 4;
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
    
    QMUIButton *one = [[QMUIButton alloc] init];
    [self addSubview:one];
    [one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(15);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.right.equalTo(leftLine.mas_right).offset(-2);
    }];
    [one addTarget:self action:@selector(hotSellBTNDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    QMUIButton *two = [[QMUIButton alloc] init];
    [self addSubview:two];
    [two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(one.mas_centerY).offset(2);
        make.left.equalTo(lab.mas_left);
        make.right.equalTo(self.mas_right).offset(-15);
        make.bottom.equalTo(one.mas_bottom);
    }];
    [two addTarget:self action:@selector(hotSellBTNDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    QMUIButton *three = [[QMUIButton alloc] init];
    [self addSubview:three];
    [three mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(one.mas_top);
        make.bottom.equalTo(one.mas_centerY).offset(-2);
        make.left.equalTo(two.mas_left);
        make.right.equalTo(two.mas_centerX).offset(-2);
    }];
    [three addTarget:self action:@selector(hotSellBTNDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    QMUIButton *four = [[QMUIButton alloc] init];
    [self addSubview:four];
    [four mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(one.mas_top);
        make.bottom.equalTo(three.mas_bottom);
        make.right.equalTo(two.mas_right);
        make.left.equalTo(three.mas_right).offset(2);
    }];
    [four addTarget:self action:@selector(hotSellBTNDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray<QMUIButton *> *btnArr = @[one, two, three, four];
    __weak __typeof(self)weakSelf = self;
    [btnArr enumerateObjectsUsingBlock:^(QMUIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tag = idx;
        UIImageView *img = [[UIImageView alloc] init];
        img.tag = idx;
        [btnArr[idx] addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(obj);
        }];
        [weakSelf.hotSellIMGArrM addObject:img];
    }];
}

- (void)hotSellBTNDidClick:(QMUIButton *)sender {
    if (sender.tag >= self.hotSellModelArr.count)return;
    HEBTakOutDetailViewController *shop = [[HEBTakOutDetailViewController alloc] init];
    shop.shop_id = self.hotSellModelArr[sender.tag].shop_id;
    [self.viewController.navigationController pushViewController:shop animated:YES];
}

- (NSArray<HEBHotSellModel *> *)hotSellModelArr {
    if (!_hotSellModelArr) {
        _hotSellModelArr = [NSArray array];
    }
    return _hotSellModelArr;
}

- (NSMutableArray<UIImageView *> *)hotSellIMGArrM {
    if (!_hotSellIMGArrM) {
        _hotSellIMGArrM = [NSMutableArray array];
    }
    return _hotSellIMGArrM;
}

@end
