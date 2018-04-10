//
//  HEBAplyDrawView.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBAplyDrawView.h"

@implementation HEBAplyDrawView

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
    self.backgroundColor = [UIColor clearColor];
    
    /** 申请提现 */
    UILabel *applyLab = [UILabel new];
    applyLab.text = @"申请提现";
    applyLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:applyLab];
    [applyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
    }];
    
    /** 您的余额： */
    UILabel *balanceLab = [UILabel new];
    balanceLab.text = @"您的余额：";
    balanceLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:balanceLab];
    [balanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(applyLab.mas_bottom).offset(5);
    }];
    UILabel *yueLab = [UILabel new];
    yueLab.text = @"88.88元";
    yueLab.textColor = [UIColor colorWithRed:239/255.0 green:117/255.0 blue:50/255.0 alpha:1.0/1.0];
    yueLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:yueLab];
    [yueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(balanceLab.mas_right);
        make.top.equalTo(applyLab.mas_bottom).offset(5);
    }];
    
    /** 每笔至少提现 */
    UILabel *withdrawLab = [UILabel new];
    withdrawLab.text = @"每笔至少提现:";
    withdrawLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:withdrawLab];
    [withdrawLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(balanceLab.mas_bottom).offset(5);
    }];
    UILabel *leastLab = [UILabel new];
    leastLab.text = @"50元";
    leastLab.textColor = [UIColor colorWithRed:239/255.0 green:117/255.0 blue:50/255.0 alpha:1.0/1.0];
    leastLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:leastLab];
    [leastLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(withdrawLab.mas_right).offset(5);
        make.top.equalTo(balanceLab.mas_bottom).offset(5);
    }];
    
    /** 每笔最多提现 */
    UILabel *moreLab = [UILabel new];
    moreLab.text = @"每笔最多提现:";
    moreLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:moreLab];
    [moreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(withdrawLab.mas_bottom).offset(5);
    }];
    UILabel *moreBlanceLab = [UILabel new];
    moreBlanceLab.text = @"10000元";
    moreBlanceLab.textColor = [UIColor colorWithRed:239/255.0 green:117/255.0 blue:50/255.0 alpha:1.0/1.0];
    moreBlanceLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:moreBlanceLab];
    [moreBlanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moreLab.mas_right).offset(5);
        make.top.equalTo(withdrawLab.mas_bottom).offset(5);
    }];
    UILabel *bankLab = [UILabel new];
    bankLab.text = @"(银行卡限制)";
    bankLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:bankLab];
    [bankLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moreBlanceLab.mas_right).offset(5);
        make.top.equalTo(withdrawLab.mas_bottom).offset(5);
    }];
    
    /** 提现方式 */
    UILabel *fangshiLab = [UILabel new];
    fangshiLab.text = @"提现方式:";
    fangshiLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:fangshiLab];
    [fangshiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(bankLab.mas_bottom).offset(5);
    }];
    UILabel *tixianLab = [UILabel new];
    tixianLab.text = @"银行提现";
    tixianLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:tixianLab];
    [tixianLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fangshiLab.mas_right).offset(5);
        make.top.equalTo(bankLab.mas_bottom).offset(5);
    }];
    
    /** 间隔线 */
    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = UIColorHex(#f1f1f1);
    [self addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(tixianLab.mas_bottom).offset(10);
        make.height.mas_equalTo(10);
    }];
    
    /** 提现金额 */
    UILabel *tixianjineLab = [UILabel new];
    tixianjineLab.text = @"提现金额";
    tixianjineLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:tixianjineLab];
    [tixianjineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(lineView1.mas_bottom).offset(20);
    }];
    UITextField *tiixanTextField = [[UITextField alloc]init];
    [self addSubview:tiixanTextField];
    tiixanTextField.placeholder = @"请输入提现金额";
    tiixanTextField.font = [UIFont systemFontOfSize:13];
    [tiixanTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.mas_offset(30);
        make.centerY.equalTo(tixianjineLab);
    }];
    
    /** 分割线 */
    UIView *linView2 = [UIView new];
    linView2.backgroundColor = UIColorHex(#f1f1f1);
    [self addSubview:linView2];
    [linView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(tixianjineLab.mas_bottom).offset(10);
        make.height.mas_equalTo(1.5);
    }];
    
    /** 姓名 */
    UILabel *nameLab = [UILabel new];
    nameLab.text = @"姓名";
    nameLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(linView2.mas_bottom).offset(15);
    }];
    UITextField *nameTextField = [[UITextField alloc]init];
    [self addSubview:nameTextField];
    nameTextField.placeholder = @"请输入姓名";
    nameTextField.font = [UIFont systemFontOfSize:13];
    [nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tiixanTextField);
        make.height.mas_offset(30);
        make.centerY.equalTo(nameLab);
    }];
    
    /** 分割线 */
    UIView *linView3 = [UIView new];
    linView3.backgroundColor = UIColorHex(#f1f1f1);
    [self addSubview:linView3];
    [linView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(nameLab.mas_bottom).offset(10);
        make.height.mas_equalTo(1.5);
    }];
    
    /** 电话 */
    UILabel *phoneLab = [UILabel new];
    phoneLab.text = @"电话";
    phoneLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(linView3.mas_bottom).offset(15);
    }];
    UITextField *phoneTextField = [[UITextField alloc]init];
    [self addSubview:phoneTextField];
    phoneTextField.placeholder = @"请输入联系电话";
    phoneTextField.font = [UIFont systemFontOfSize:13];
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tiixanTextField);
        make.height.mas_offset(30);
        make.centerY.equalTo(phoneLab);
    }];
    /** 分割线 */
    UIView *linView4 = [UIView new];
    linView4.backgroundColor = UIColorHex(#f1f1f1);
    [self addSubview:linView4];
    [linView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(phoneLab.mas_bottom).offset(10);
        make.height.mas_equalTo(1.5);
    }];
    
    /** 开户银行 */
    UILabel *openLab = [UILabel new];
    openLab.text = @"开户银行";
    openLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:openLab];
    [openLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(linView4.mas_bottom).offset(15);
    }];
    UITextField *openTextField = [[UITextField alloc]init];
    [self addSubview:openTextField];
    openTextField.placeholder = @"如“中国工商银行”";
    openTextField.font = [UIFont systemFontOfSize:13];
    [openTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tiixanTextField);
        make.height.mas_offset(30);
        make.centerY.equalTo(openLab);
    }];
    /** 分割线 */
    UIView *linView5 = [UIView new];
    linView5.backgroundColor = UIColorHex(#f1f1f1);
    [self addSubview:linView5];
    [linView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(openLab.mas_bottom).offset(10);
        make.height.mas_equalTo(1.5);
    }];
    
    /** 所属分行 */
    UILabel *branchLab = [UILabel new];
    branchLab.text = @"所属分行";
    branchLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:branchLab];
    [branchLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(linView5.mas_bottom).offset(15);
    }];
    UITextField *branchTextField = [[UITextField alloc]init];
    [self addSubview:branchTextField];
    branchTextField.placeholder = @"如“广州黄埔支行”";
    branchTextField.font = [UIFont systemFontOfSize:13];
    [branchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tiixanTextField);
        make.height.mas_offset(30);
        make.centerY.equalTo(branchLab);
    }];
    /** 分割线 */
    UIView *linView6 = [UIView new];
    linView6.backgroundColor = UIColorHex(#f1f1f1);
    [self addSubview:linView6];
    [linView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(branchLab.mas_bottom).offset(10);
        make.height.mas_equalTo(1.5);
    }];
    
    /** 开户行所在地 */
    UILabel *dizhiLab = [UILabel new];
    dizhiLab.text = @"开户行所在地";
    dizhiLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:dizhiLab];
    [dizhiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(linView6.mas_bottom).offset(15);
    }];
    UITextField *kaihuhangTextField = [[UITextField alloc]init];
    [self addSubview:kaihuhangTextField];
    kaihuhangTextField.placeholder = @"如“广州省，广州市”";
    kaihuhangTextField.font = [UIFont systemFontOfSize:13];
    [kaihuhangTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tiixanTextField);
        make.height.mas_offset(30);
        make.centerY.equalTo(dizhiLab);
    }];
    UIButton *xuanBtn = [[UIButton alloc]init];
    [xuanBtn addTarget:self action:@selector(cictyClick) forControlEvents:UIControlEventTouchUpInside];
    [xuanBtn setImage:[UIImage imageNamed:@"xuanzechengshi"] forState:UIControlStateNormal];
    [self addSubview:xuanBtn];
    [xuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(linView6.mas_bottom).offset(15);
    }];
    /** 分割线 */
    UIView *linView7 = [UIView new];
    linView7.backgroundColor = UIColorHex(#f1f1f1);
    [self addSubview:linView7];
    [linView7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(dizhiLab.mas_bottom).offset(10);
        make.height.mas_equalTo(1.5);
    }];
    
    /** 银行卡号 */
    UILabel *cardLab = [UILabel new];
    cardLab.text = @"银行卡号";
    cardLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:cardLab];
    [cardLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(linView7.mas_bottom).offset(15);
    }];
    UITextField *cardTextField = [[UITextField alloc]init];
    [self addSubview:cardTextField];
    cardTextField.placeholder = @"请输入银行卡号";
    cardTextField.font = [UIFont systemFontOfSize:13];
    [cardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tiixanTextField);
        make.height.mas_offset(30);
        make.centerY.equalTo(cardLab);
    }];
    
    /** 分割线 */
    UIView *linView8 = [UIView new];
    linView8.backgroundColor = UIColorHex(#f1f1f1);
    [self addSubview:linView8];
    [linView8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(cardLab.mas_bottom).offset(10);
        make.height.mas_equalTo(1.5);
    }];
   
    
    
    
     
    
}
#pragma mark - 点击事件
- (void)cictyClick
{
    NSLog(@"点击了选择按钮");
}
- (void)sureClick
{
    NSLog(@"点击了确定提现按钮");
}
@end
