//
//  HEBAccountView.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBAccountView.h"

@implementation HEBAccountView

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
    UIView *RgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    [self addSubview:RgView];
    
    /** 微信支付 */
    UIButton *weChartBtn = [UIButton new];
    [weChartBtn setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
    [RgView addSubview:weChartBtn];
    [weChartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(RgView.mas_left).offset(15);
        make.top.equalTo(RgView).offset(20);
    }];
    
    UILabel *weLab = [UILabel new];
    weLab.text = @"微信支付";
    weLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:weLab];
    [weLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weChartBtn.mas_right).offset(10);
        make.bottom.equalTo(weChartBtn.mas_bottom).offset(-5);
    }];
    
    UIButton *clickBtn = [UIButton new];
    [clickBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [clickBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [clickBtn addTarget:self action:@selector(wechartClick:) forControlEvents:UIControlEventTouchUpInside];
    [RgView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(RgView.mas_right).offset(-15);
        make.top.equalTo(RgView).offset(20);
    }];
    
    /** 线条 */
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [RgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(RgView).offset(15);
        make.right.equalTo(RgView).offset(-15);
        make.height.mas_equalTo(1);
        make.top.equalTo(weChartBtn.mas_bottom).offset(10);
    }];
    
    /** 支付宝支付 */
    UIButton *payBtn = [UIButton new];
    [payBtn setImage:[UIImage imageNamed:@"zhifubao"] forState:UIControlStateNormal];
    [RgView addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(RgView.mas_left).offset(15);
        make.top.equalTo(lineView.mas_bottom).offset(10);
    }];
    
    UILabel *payLab = [UILabel new];
    payLab.text = @"支付宝支付";
    payLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:payLab];
    [payLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payBtn.mas_right).offset(10);
        make.bottom.equalTo(payBtn.mas_bottom).offset(-5);
    }];
    
    UIButton *zhbBtn = [UIButton new];
    [zhbBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [zhbBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [zhbBtn addTarget:self action:@selector(zfbClick:) forControlEvents:UIControlEventTouchUpInside];
    [RgView addSubview:zhbBtn];
    [zhbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(RgView.mas_right).offset(-15);
        make.top.equalTo(lineView.mas_bottom).offset(15);
    }];
    UIView *bomView = [UIView new];
    bomView.backgroundColor = [UIColor lightGrayColor];
    [RgView addSubview:bomView];
    [bomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(RgView).offset(15);
        make.right.equalTo(RgView).offset(-15);
        make.height.mas_equalTo(1);
        make.top.equalTo(payBtn.mas_bottom).offset(10);
    }];
    
    /** 账户充值 */
    UILabel *sumLab = [UILabel new];
    sumLab.text = @"金额";
    [RgView addSubview:sumLab];
    [sumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payBtn);
        make.top.equalTo(bomView.mas_bottom).offset(15);
    }];
    
    UITextField *sumText = [[UITextField alloc]init];
    sumText.placeholder = @"请输入充值金额";
    sumText.font = [UIFont systemFontOfSize:14];
    [RgView addSubview:sumText];
    [sumText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sumLab.mas_right).offset(20);
        make.top.equalTo(bomView.mas_bottom).offset(10);
        make.height.mas_offset(30);
    }];
    
    /** 线条 */
    UIView *lowView = [UIView new];
    lowView.backgroundColor = [UIColor lightGrayColor];
    [RgView addSubview:lowView];
    [lowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(RgView).offset(15);
        make.right.equalTo(RgView).offset(-15);
        make.height.mas_equalTo(1);
        make.top.equalTo(sumLab.mas_bottom).offset(10);
    }];
    
    /** 确定按钮 */
    UIButton *confirmBtn = [[UIButton alloc]init];
    [confirmBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setImage:[UIImage imageNamed:@"quidingzhifu"] forState:UIControlStateNormal];
    [self addSubview:confirmBtn];
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lowView.mas_bottom).offset(20);
        make.centerX.equalTo(self);
    }];
    
}
#pragma mark - 按钮的点击事件
- (void)wechartClick:(UIButton *)button {
    NSLog(@"微信支付");
     button.selected = !button.selected;

}
- (void)zfbClick:(UIButton *)button {
    NSLog(@"支付宝支付");
    button.selected = !button.selected;
    
}
- (void)sureClick
{
    NSLog(@"点击了确定支付按钮");
}
@end
