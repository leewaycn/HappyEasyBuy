//
//  HEBGasCardTopView.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/25.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBGasCardTopView.h"

@implementation HEBGasCardTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI
- (void)setupUI
{
    /** 加油箱 */
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiayouka"]];
    [self addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(80);
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(20);
    }];
    
    /** 线条 */
    UIView *lineView = [UIView new];
    lineView.backgroundColor = UIColorHex(#f1f1f1);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(imageV.mas_bottom).offset(20);
        make.height.mas_equalTo(8);
    }];
    
    /** 加油卡类型 */
    UILabel *nameLab = [UILabel new];
    nameLab.text = @"加油卡类型";
    [self addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(lineView.mas_bottom).offset(10);
    }];
    
    /** 中石油 */
    UIButton *zsyBtn = [UIButton new];
    [zsyBtn setImage:[UIImage imageNamed:@"zhongsjiypou"] forState:UIControlStateNormal];
    [zsyBtn setImage:[UIImage imageNamed:@"zhongshiyou-cheng"] forState:UIControlStateSelected];
    [zsyBtn addTarget:self action:@selector(zfbClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:zsyBtn];
    [zsyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLab.mas_right).offset(30);
        make.top.equalTo(lineView.mas_bottom).offset(10);
    }];
    
    /** 中石化 */
    UIButton *zshBtn = [UIButton new];
    [zshBtn setImage:[UIImage imageNamed:@"zhongshihau"] forState:UIControlStateNormal];
    [zshBtn setImage:[UIImage imageNamed:@"zhongshihua-cheng"] forState:UIControlStateSelected];
    [zshBtn addTarget:self action:@selector(zfbClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:zshBtn];
    [zshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(zsyBtn.mas_right).offset(30);
        make.top.equalTo(lineView.mas_bottom).offset(10);
    }];
    
    /** */
    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = UIColorHex(#f1f1f1);
    [self addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(zshBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    /** 产品 */
    UILabel *productLab = [UILabel new];
    productLab.text = @"产品:";
    [self addSubview:productLab];
    [productLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(lineView1.mas_bottom).offset(10);
    }];
    
    /** 加油卡 */
    UIButton *jykBtn = [UIButton new];
    [jykBtn setImage:[UIImage imageNamed:@"jiayoukaa"] forState:UIControlStateNormal];
    [jykBtn setImage:[UIImage imageNamed:@"jiayoukaa-cheng"] forState:UIControlStateSelected];
    [jykBtn addTarget:self action:@selector(zfbClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:jykBtn];
    [jykBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(productLab.mas_bottom).offset(10);
    }];
    
    /** 加油卡 */
    UIButton *rightjykBtn = [UIButton new];
    [rightjykBtn setImage:[UIImage imageNamed:@"jiayoukaa"] forState:UIControlStateNormal];
    [rightjykBtn setImage:[UIImage imageNamed:@"jiayoukaa-cheng"] forState:UIControlStateSelected];
    [rightjykBtn addTarget:self action:@selector(zfbClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightjykBtn];
    [rightjykBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(productLab.mas_bottom).offset(10);
    }];
    
    
    
    
}
#pragma mark - 按钮的点击事件
- (void)zfbClick:(UIButton *)button {
    NSLog(@"中石油");
    button.selected = !button.selected;
    
}
@end
