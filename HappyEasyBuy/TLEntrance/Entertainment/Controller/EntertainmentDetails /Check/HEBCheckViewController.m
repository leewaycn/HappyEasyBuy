//
//  HEBCheckViewController.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/26.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBCheckViewController.h"

@interface HEBCheckViewController ()
//支付总额输入框
@property(strong, nonatomic)UITextField *totalFiel;
//满减选择状态按钮
@property(strong, nonatomic)UIButton *fullCutBtn;
//优惠券选择状态按钮
@property(strong, nonatomic)UIButton *couponSelectBtn;
//优惠券选择按钮
@property(strong, nonatomic)UIButton *couponRightBtn;
//实付金额
@property(strong, nonatomic)UILabel *paidpriceLabel;
//确定买单按钮
@property(strong ,nonatomic)UIButton *checkBtn;


@end

@implementation HEBCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorHex(#f1f1f1);
//    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

#pragma mark-setupUI
-(void)setupUI{
    
#pragma mark-// 消费总额View
    UIView *totalView = [UIView new];
    totalView.backgroundColor = [UIColor whiteColor];
    totalView.dividingLine = YES;
    [self.view addSubview:totalView];
    [totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.mas_offset(50);
    }];
    
    UILabel *totalLab = [UILabel new];
    totalLab.text = @"消费总额:";
    totalLab.font = [UIFont systemFontOfSize:15];
    totalLab.textColor = [UIColor lightGrayColor];
    [totalView addSubview:totalLab];
    [totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(totalView).offset(20);
        //make.top.equalTo(totalView).offset(10);
        make.centerY.equalTo(totalView);
    }];
    
    UITextField *totalFiel = [UITextField new];
    totalFiel.placeholder = @"询问服务员后输入";
    totalFiel.textAlignment = NSTextAlignmentRight;
    totalFiel.font = [UIFont systemFontOfSize:12];
    [totalFiel addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
    [totalView addSubview:totalFiel];
    [totalFiel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(totalView);
        make.right.equalTo(totalView).offset(-20);
        make.width.mas_offset(100);
    }];

 
#pragma mark- 满减View
    UIView *fullCutView = [[UIView alloc]init];
    fullCutView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:fullCutView];
    [fullCutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(totalView.mas_bottom).offset(5);
        make.height.mas_offset(50);
        
    }];
//    满减选择按钮
    UIButton *fullCutBtn = [[UIButton alloc]init];
    fullCutBtn.selected = YES;
    [fullCutBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [fullCutBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [fullCutBtn addTarget:self action:@selector(fullCutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [fullCutView addSubview:fullCutBtn];
    [fullCutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fullCutView).mas_offset(10);
        make.centerY.equalTo(fullCutView);
        make.height.with.mas_offset(20);
        
    }];
    
    UILabel *fullCutLabel = [UILabel new];
    fullCutLabel.font = [UIFont systemFontOfSize:12];
    fullCutLabel.text = @"满0.00元减0.00元";
    [fullCutView addSubview:fullCutLabel];
    [fullCutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fullCutBtn.mas_right).offset(15);
        make.centerY.equalTo(fullCutBtn.mas_centerY);
    }];
    
#pragma mark- 选择优惠券View
    UIView *couponView = [[UIView alloc]init];
    couponView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:couponView];
    [couponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(fullCutView.mas_bottom).offset(5);
        make.height.mas_offset(50);
        
    }];
    
    UIButton *couponSelectBtn = [[UIButton alloc]init];
    _couponSelectBtn = couponSelectBtn;
    [couponSelectBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [couponSelectBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [couponSelectBtn addTarget:self action:@selector(couponSelectBtn) forControlEvents:UIControlEventTouchUpInside];
    [couponView addSubview:couponSelectBtn];
    [couponSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(couponView).offset(10);
        make.centerY.equalTo(couponView.mas_centerY);
        
    }];
    
    UILabel *couponLabel = [UILabel new];
    couponLabel.font = [UIFont systemFontOfSize:12];
    couponLabel.text = @"选择优惠券";
    [couponView addSubview: couponLabel];
    [couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(couponSelectBtn.mas_right).offset(15);
        make.centerY.equalTo(couponSelectBtn.mas_centerY);
    }];
    
    UIButton *couponRightBtn = [UIButton new];
    _couponRightBtn = couponRightBtn;
    [couponRightBtn setImage:[UIImage imageNamed:@"xiangxia"] forState:UIControlStateNormal];
    [couponRightBtn setImage:[UIImage imageNamed:@"xiangshang"] forState:UIControlStateSelected];
    [couponRightBtn addTarget:self action:@selector(setCouponRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [couponView addSubview:couponRightBtn];
    [couponRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(couponView.mas_right).offset(-10);
        make.centerY.equalTo(couponView);
        make.width.height.mas_offset(20);
    }];

    
#pragma mark- 实付金额View
    UIView *paidView = [[UIView alloc]init];
    paidView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:paidView];
    [paidView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(couponView.mas_bottom).offset(5);
        make.height.mas_offset(50);
    }];
    
    UILabel *paidLabel = [UILabel new];
    paidLabel.text = @"实付金额";
    paidLabel.font = [UIFont systemFontOfSize:12];
    [paidView addSubview: paidLabel];
    [paidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(paidView).offset(10);
        make.centerY.equalTo(paidView);
        
    }];
    
    UILabel *paidpriceLabel = [[UILabel alloc]init];
    _paidpriceLabel = paidpriceLabel;
    paidpriceLabel.text = @"￥0";
    paidpriceLabel.textColor = [UIColor orangeColor];
    paidpriceLabel.font = [UIFont systemFontOfSize:12];
    [paidView addSubview:paidpriceLabel];
    [paidpriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(paidView).offset(-10);
        make.centerY.equalTo(paidView);
    }];
    
    
    
    
    
    
//确定买单按钮
    UIButton *checkBtn = [[UIButton alloc]init];
    _checkBtn = checkBtn;
    checkBtn.backgroundColor = [UIColor grayColor];
    [checkBtn setTitle:@"确定买单" forState:UIControlStateNormal];
//    checkBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [self.view addSubview:checkBtn];
    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.mas_offset(40);
        make.top.equalTo(paidView.mas_bottom).offset(30);
        
    }];
    
//    底部提示Label
    UILabel *promptLabel = [[UILabel alloc]init];
    promptLabel.font = [UIFont systemFontOfSize:12];
//    promptLabel.textColor = UIColorHex(#f1f1f1);
    promptLabel.text = @"买单仅限于到店支付，请确认金额后提交";
    [self.view addSubview:promptLabel];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(checkBtn);
        make.top.equalTo(checkBtn.mas_bottom).offset(40);
        
    }];
}



#pragma mark- 实时监听文本框变化
-(void)passConTextChange:(id)sender{
    UITextField* target=(UITextField*)sender;
    NSLog(@"%@",target.text);
    
    if (target.text.length > 0) {
        self.checkBtn.titleLabel.text = [NSString stringWithFormat:@"%@确定买单",target.text] ;
        self.paidpriceLabel.text = [NSString stringWithFormat:@"￥%@",target.text] ;;
        self.checkBtn.backgroundColor = [UIColor orangeColor];
    }else if (target.text.length == 0){

        self.paidpriceLabel.text = @"￥0";
        [self.checkBtn setTitle:@"确定买单" forState:UIControlStateNormal];
        self.checkBtn.backgroundColor = [UIColor grayColor];

        }
}


#pragma mark-按钮点击事件
-(void)fullCutBtnClick:(UIButton *)sender{
    
    NSLog(@"点击满减选择按钮");
    
}

-(void)couponSelectBtnClick:(UIButton *)sender{
    
    NSLog(@"点击优惠券选择按钮");

}



-(void)couponRightBtnClick:(UIButton *)sender{
    
    NSLog(@"择优惠券");
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = @"买单";
    
}


@end
