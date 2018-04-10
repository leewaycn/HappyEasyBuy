//
//  HEBPlaceOrderVC.m



//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/9.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//
#define FontSize 14

#import "HEBPlaceOrderVC.h"

@interface HEBPlaceOrderVC ()
@property(nonatomic, weak) UILabel *numLabel;
@end
NSInteger num = 1;

@implementation HEBPlaceOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorHex(#f1f1f1);
    
    [self setupUI];

}

-(void)setupUI{
//    topView
    UIView *topView = [UIView new];
    topView.dividingLine = YES;
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.mas_offset(80);
    }];
    
    UIImageView *iconImageV = [UIImageView new];
    iconImageV.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(10);
        make.centerY.equalTo(topView);
        make.width.height.mas_offset(60);
    }];
    
    UILabel *topLabel = [UILabel new];
    topLabel.text = @"topLabel";
    topLabel.font = [UIFont systemFontOfSize:FontSize];
    [self.view addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageV.mas_right).offset(20);
        make.centerY.equalTo(iconImageV).offset(-20);
    }];
    
    UILabel *TopMoneyLabel = [UILabel new];
    TopMoneyLabel.text = @"￥100.00";
    TopMoneyLabel.font = [UIFont systemFontOfSize:FontSize];
    [topView addSubview:TopMoneyLabel];
    [TopMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageV.mas_right).offset(20);
        make.centerY.equalTo(iconImageV).offset(20);
    }];
    
//    数量View
    UIView *numberView = [UIView new];
    numberView.backgroundColor = [UIColor whiteColor];
    numberView.dividingLine = YES;
    [self.view addSubview:numberView];
    [numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_offset(40);
        make.top.equalTo(topView.mas_bottom);
    }];
    
    UILabel *numberTitl = [UILabel new];
    numberTitl.text = @"数量";
    numberTitl.font = [UIFont systemFontOfSize:FontSize];
    [numberView addSubview:numberTitl];
    [numberTitl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numberView).offset(10);
        make.centerY.equalTo(numberView);
    }];
    
    
    UIButton *numberRightBtn = [UIButton new];
    [numberRightBtn setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
    [numberRightBtn addTarget:self action:@selector(numberRightBtnClick:) forControlEvents:UIControlEventTouchUpInside ];
    [numberView addSubview: numberRightBtn ];
    [numberRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(numberView).offset(-20);
        make.centerY.equalTo(numberView);
        make.width.mas_offset(40);
        make.height.mas_offset(30);
    }];
    
    
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"kuan.png"]];
    UILabel *numLabel = [UILabel new];
    _numLabel = numLabel;
    [numLabel setBackgroundColor:color];
    numLabel.text = @"1";
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.font = [UIFont systemFontOfSize:FontSize];
    [numberView addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(numberRightBtn.mas_left).offset(-10);
        make.centerY.equalTo(numberView);
        make.width.mas_offset(40);
//        make.height.mas_offset(30);
    }];




    UIButton *numberLeftBtn = [UIButton new];
    [numberLeftBtn setImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
    [numberLeftBtn addTarget:self action:@selector(numberleftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [numberView addSubview: numberLeftBtn ];
    [numberLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(numLabel.mas_left).offset(-10);
        make.centerY.equalTo(numberView);
        make.width.mas_offset(40);
        make.height.mas_offset(30);

    }];
//
    
//  小计
    UIView *subtotalView = [UIView new];
    subtotalView.backgroundColor = [UIColor whiteColor];
    subtotalView.dividingLine = YES;
    [self.view addSubview:subtotalView];
    [subtotalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(numberView.mas_bottom);
        make.height.mas_offset(40);
        
    }];
    UILabel *subtotalTitlLabel = [UILabel new];
    subtotalTitlLabel.text = @"小计";
    subtotalTitlLabel.font = [UIFont systemFontOfSize:FontSize];
    [subtotalView addSubview:subtotalTitlLabel];
    [subtotalTitlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(subtotalView).offset(10);
        make.centerY.equalTo(subtotalView);
    }];
    
    UILabel *subtotalMoneyLabel = [UILabel new];
    subtotalMoneyLabel.text = @"￥100.00";
    subtotalMoneyLabel.font = [UIFont systemFontOfSize:FontSize];
    subtotalMoneyLabel.textColor = [UIColor orangeColor];
    [subtotalView addSubview: subtotalMoneyLabel];
    [subtotalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(subtotalView).offset(-10);
        make.centerY.equalTo(subtotalView);
    }];
    
    
    
//  实付View
    UIView *paidView = [UIView new];
    paidView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:paidView];
    [paidView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(subtotalView.mas_bottom).offset(10);
        make.height.mas_offset(40);
        
    }];
    
    UILabel *paidTitlLabel = [UILabel new];
    paidTitlLabel.text = @"实付金额";
    paidTitlLabel.font = [UIFont systemFontOfSize:FontSize];
    [paidView addSubview:paidTitlLabel];
    [paidTitlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(paidView).offset(10);
        make.centerY.equalTo(paidView);
    }];
    
    UILabel *paidMoneyLabel = [UILabel new];
    paidMoneyLabel.text = @"￥100.00";
    paidMoneyLabel.font = [UIFont systemFontOfSize:FontSize];
    paidMoneyLabel.textColor = [UIColor orangeColor];
    [paidView addSubview:paidMoneyLabel];
    [paidMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(paidView).offset(-10);
        make.centerY.equalTo(paidView);
        
    }];
    
//    手机号View
    UIView *phoneView = [UIView new];
    phoneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(paidView.mas_bottom).offset(10);
        make.height.mas_offset(40);
    }];
    
    UILabel *phoneTitlLabel = [UILabel new];
    phoneTitlLabel.text = @"手机号";
    phoneTitlLabel.font = [UIFont systemFontOfSize:FontSize];
    [phoneView addSubview: phoneTitlLabel ];
    [phoneTitlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneView).offset(10);
        make.centerY.equalTo(phoneView);
        
    }];
    
    UILabel *phoneLabel = [UILabel new];
    phoneLabel.text = @"123456789";
    phoneLabel.font = [UIFont systemFontOfSize:FontSize];
    [phoneView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(phoneView).offset(-10);
        make.centerY.equalTo(phoneView);
    }];
    
//    底部按钮
    UIButton *bottomBtn = [UIButton new];
    [bottomBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    bottomBtn.backgroundColor = [UIColor orangeColor];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize: FontSize];
    [bottomBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_offset(40);
    }];
    
}

#pragma mark-加BtnClick
-(void)numberRightBtnClick:(UIButton *)sender{
    
    NSLog(@"加+");
    
    self.numLabel.text = [NSString stringWithFormat:@"%ld",num++];
}

#pragma mark-减BtnClick
-(void)numberleftBtnClick:(UIButton *)sender{
    
    NSLog(@"减-");

    self.numLabel.text = [NSString stringWithFormat:@"%ld",num--];

}

#pragma mark-提交订单BtnClick
-(void)bottomBtnClick:(UIButton *)sender{
    
    NSLog(@"提交订单");
    
}

@end
