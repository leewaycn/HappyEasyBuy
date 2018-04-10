//
//  HEBProductDetailsVC.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/6.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//
#define FontSize 14

#import "HEBProductDetailsVC.h"
#import "HEBCycleScrollView.h"
@interface HEBProductDetailsVC ()
//轮播图
@property(nonatomic, weak)HEBCycleScrollView *cyView;
//    顶部产品说明 标题View
@property(nonatomic, weak) UIView *topExplainTitlView;
//产品说明View
@property(nonatomic, weak) UIView *explainView;

@end

@implementation HEBProductDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"产品详情";
    self.view.backgroundColor = UIColorHex(#f1f1f1);
    [self verbView];
    [self addTopExplainTitlView];
    [self addExplainView];
}

#pragma mark--添加顶部产品说明 标题View
-(void)addTopExplainTitlView{
//    顶部产品说明View
    UIView *topExplainTitlView = [UIView new];
    _topExplainTitlView = topExplainTitlView;
    topExplainTitlView.bottomLine = YES;
    [self.view addSubview:topExplainTitlView];
    [topExplainTitlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.cyView.mas_bottom);
        make.height.mas_offset(30);
    }];
//    产品说明
    UILabel *titlLabel = [UILabel new];
    titlLabel.text = @"产品说明";
    titlLabel.font = [UIFont systemFontOfSize:15];
    [topExplainTitlView addSubview:titlLabel];
    [titlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topExplainTitlView).offset(10);
        make.centerY.equalTo(topExplainTitlView);
    }];
//
}
#pragma mark- 产品说明View
-(void)addExplainView{
    UIView *explainView = [UIView new];
//    explainView.bottomLine = YES;
    _explainView = explainView;
    [self.view addSubview: explainView ];
    [explainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topExplainTitlView.mas_bottom);
    }];
//    产品名
    UILabel *productNameTitl = [UILabel new];
    productNameTitl.text = @"产品名：";
    productNameTitl.font = [UIFont systemFontOfSize:FontSize];
    [explainView addSubview: productNameTitl];
    [productNameTitl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(explainView).offset(20);
        make.top.equalTo(explainView).offset(10);
    }];
    
    UILabel *productName = [UILabel new];
    productName.text = @"企业网站定制";
    productName.font = [UIFont systemFontOfSize:FontSize];
    [explainView addSubview:productName];
    [productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(productNameTitl.mas_right);
        make.centerY.equalTo(productNameTitl);
    }];
//    参数
    UILabel *parameterTitlLabel = [UILabel new];
    parameterTitlLabel.text = @"参 数：";
    parameterTitlLabel.font = [UIFont systemFontOfSize:FontSize];
    [explainView addSubview:parameterTitlLabel];
    [parameterTitlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(productNameTitl);
        make.top.equalTo(productNameTitl.mas_bottom).offset(15);
    }];
    
    UILabel *parameterLabel = [UILabel new];
    parameterLabel.text = @"坐等传参数";
    parameterLabel.font = [UIFont systemFontOfSize:FontSize];
    [explainView addSubview:parameterLabel];
    [parameterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(productName);
        make.centerY.equalTo(parameterTitlLabel);
    }];
    
//  用途
    UILabel *purposeTitlLabel = [UILabel new];
    purposeTitlLabel.text = @"用 途：";
    purposeTitlLabel.font = [UIFont systemFontOfSize:FontSize];
    [explainView addSubview:purposeTitlLabel];
    [purposeTitlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(parameterTitlLabel);
        make.top.equalTo(parameterTitlLabel.mas_bottom).offset(15);
    }];
    
    UILabel *purposeLabel = [UILabel new];
    purposeLabel.text = @"展示企业实力";
    purposeLabel.font = [UIFont systemFontOfSize:FontSize];
    [explainView addSubview:purposeLabel];
    [purposeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(productName);
        make.centerY.equalTo(purposeTitlLabel);
    }];
    
}



#pragma mark//添加轮播图
- (void)verbView
{
    HEBCycleScrollView *cyView = [[HEBCycleScrollView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 140*SCREEN_WIDTH/375)];
    _cyView = cyView;
    [cyView startLocationCycleScrollViewType:@"7"];
    [self.view addSubview:cyView];
}

@end
