//
//  HEBShippingAddressView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/27.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBShippingAddressView.h"
#import "HEBPCAModel.h"

@interface HEBShippingAddressView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong) NSArray<HEBPCAModel *> *pcaModelArr;

/** 暂存省 */
@property(nonatomic, assign) NSInteger province;

/** 暂存市 */
@property(nonatomic, assign) NSInteger city;

/** 暂存区 */
@property(nonatomic, assign) NSInteger area;

@end

@implementation HEBShippingAddressView

- (void)loadView {
    self.province = 0;
    self.city = 0;
    self.area = 0;
    self.dividingLine = YES;
    self.backgroundColor = UIColorHex(#f1f1f1);
    QMUILabel *userLab = [[QMUILabel alloc] init];
    userLab.text = @"联系人";
    userLab.font = UIFontMake(16);
    userLab.textColor = BASEBLACK;
    [self addSubview:userLab];
    [userLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.equalTo(self.mas_left).offset(15);
    }];
    UIView *userBGView = [[UIView alloc] init];
    userBGView.backgroundColor = UIColorWhite;
    [self addSubview:userBGView];
    [userBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userLab.mas_bottom).offset(5);
        make.left.equalTo(userLab.mas_left);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_offset(150);
    }];
    userBGView.layer.cornerRadius = 10;
    userBGView.layer.masksToBounds = YES;
    userBGView.layer.borderColor = UIColorHex(#e7e7e7).CGColor;
    userBGView.layer.borderWidth = 1;
    
    QMUILabel *user = [[QMUILabel alloc] init];
    user.text = @"姓名:";
    user.font = UIFontMake(16);
    [userBGView addSubview:user];
    [user mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userBGView.mas_left).offset(10);
        make.top.equalTo(userBGView.mas_top).offset(25);
        make.width.mas_offset(40);
    }];
    
    QMUITextField *userName = [[QMUITextField alloc] init];
    userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    selfClass(userName);
    userName.placeholder = @"请输入姓名";
    userName.font = user.font;
    [userBGView addSubview:userName];
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(user.mas_centerY);
        make.left.equalTo(user.mas_right).offset(2);
        make.right.equalTo(userBGView.mas_right).offset(-10);
        make.height.mas_offset(40);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorHex(#e7e7e7);
    [userBGView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(user.mas_left);
        make.right.equalTo(userName.mas_right);
        make.top.equalTo(userName.mas_bottom);
        make.height.mas_offset(1);
    }];
    
    for (int i = 0; i < 2; i ++) {
        QMUIButton *sex = [[QMUIButton alloc] init];
        sex.titleLabel.font = UIFontMake(16);
        [sex setImage:UIImageMake(@"支付方式未选中") forState:UIControlStateNormal];
        [sex setImage:UIImageMake(@"支付方式选中") forState:UIControlStateSelected];
        [sex setTitle:i==0?@" 先生":@" 女士" forState:UIControlStateNormal>>UIControlStateSelected];
        [sex setTitleColor:BASEBLACK forState:UIControlStateNormal>>UIControlStateSelected];
        sex.selected = i;
        sex.userInteractionEnabled = !i;
        sex.tag = 100+i;
        [userBGView addSubview:sex];
        [sex mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom);
            make.width.equalTo(userBGView.mas_width).multipliedBy(0.5);
            make.height.mas_offset(44);
            make.left.equalTo((i==0?userBGView.mas_left:userBGView.mas_centerX));
        }];
        [sex addTarget:self action:@selector(sexDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = line.backgroundColor;
    [userBGView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(45);
        make.left.right.height.equalTo(line);
    }];
    
    QMUITextField * mobNumber = [[QMUITextField alloc] init];
    selfClass(mobNumber);
    mobNumber.maximumTextLength = 11;
    mobNumber.clearButtonMode = userName.clearButtonMode;
    mobNumber.keyboardType = UIKeyboardTypeNumberPad;
    mobNumber.placeholder = @"请输入手机号";
    mobNumber.font = userName.font;
    [userBGView addSubview:mobNumber];
    [mobNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.bottom.equalTo(userBGView.mas_bottom);
        make.left.right.equalTo(userName);
    }];
    
    QMUILabel *mobLab = [[QMUILabel alloc] init];
    mobLab.text = @"手机:";
    mobLab.font = userLab.font;
    [userBGView addSubview:mobLab];
    [mobLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(user);
        make.centerY.equalTo(mobNumber.mas_centerY);
    }];
    
    QMUILabel *locationLab = [[QMUILabel alloc] init];
    locationLab.text = @"收货地址";
    locationLab.font = userLab.font;
    locationLab.textColor = userLab.textColor;
    [self addSubview:locationLab];
    [locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userBGView.mas_bottom).offset(5);
        make.left.equalTo(userLab.mas_left);
    }];
    
    UIView *locationBGView = [[UIView alloc] init];
    locationBGView.backgroundColor = UIColorWhite;
    [self addSubview:locationBGView];
    [locationBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(userBGView);
        make.top.equalTo(locationLab.mas_bottom).offset(3);
        make.height.mas_offset(120);
    }];
    locationBGView.layer.cornerRadius = userBGView.layer.cornerRadius;
    locationBGView.layer.masksToBounds = YES;
    locationBGView.layer.borderColor = userBGView.layer.borderColor;
    locationBGView.layer.borderWidth = userBGView.layer.borderWidth;
    
    QMUILabel *loc = [[QMUILabel alloc] init];
    loc.text = @"地址:";
    loc.font = UIFontMake(16);
    [locationBGView addSubview:loc];
    [loc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(user);
        make.top.equalTo(locationBGView.mas_top).offset(20);
    }];
    
    QMUITextField *location = [[QMUITextField alloc] init];
    @weakify(location);
    __weak __typeof(self)weakSelf = self;
    [location addBlockForControlEvents:UIControlEventEditingDidBegin block:^(id  _Nonnull sender) {
        if (!weak_location.hasText) {
            weak_location.text = [NSString stringWithFormat:@"%@%@%@", weakSelf.pcaModelArr[weakSelf.province].name, weakSelf.pcaModelArr[weakSelf.province].city[weakSelf.city].name, weakSelf.pcaModelArr[weakSelf.province].city[weakSelf.city].area[weakSelf.area]];
        }
    }];
    location.borderStyle = UITextBorderStyleRoundedRect;
    selfClass(location);
    location.placeholder = @"点击选择省/市/县（区）";
    location.font = userName.font;
    [locationBGView addSubview:location];
    [location mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(userName);
        make.centerY.equalTo(loc.mas_centerY);
    }];
    UIPickerView *pick = [[UIPickerView alloc] init];
    pick.dataSource = self;
    pick.delegate = self;
    location.inputView = pick;
    
    QMUITextView *address = [[QMUITextView alloc] init];
    selfClass(address);
    address.placeholder = @"请输入详细地址";
    address.font = location.font;
    [locationBGView addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(location);
        make.bottom.equalTo(locationBGView.mas_bottom).offset(-3);
        make.top.equalTo(location.mas_bottom).offset(5);
    }];
    address.layer.cornerRadius = locationBGView.layer.cornerRadius;
    address.layer.masksToBounds = YES;
    address.layer.borderColor = locationBGView.layer.borderColor;
    address.layer.borderWidth = locationBGView.layer.borderWidth;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.pcaModelArr.count;
    }else if (component == 1) {
        return self.pcaModelArr[self.province].city.count;
    }
    return self.pcaModelArr[self.province].city[self.city].area.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.pcaModelArr[row].name;
    }else if (component == 1) {
        return self.pcaModelArr[self.province].city[row].name;
    }
    return self.pcaModelArr[self.province].city[self.city].area[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0 && self.province != row) {
        self.province = row;
        self.city = 0;
        self.area = 0;
        self.province = [pickerView selectedRowInComponent:0];
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    }else if (component == 1 && self.city != row) {
        self.city = row;
        self.area = 0;
        [pickerView reloadComponent:2];
    }else {
        self.area = row;
    }
    self.location.text = [NSString stringWithFormat:@"%@%@%@", self.pcaModelArr[self.province].name, self.pcaModelArr[self.province].city[self.city].name, self.pcaModelArr[self.province].city[self.city].area[self.area]];
}

- (void)sexDidClick:(QMUIButton *)sender {
    [self.address resignFirstResponder];
    [self.userName resignFirstResponder];
    [self.mobNumber resignFirstResponder];
    [self.location resignFirstResponder];
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    QMUIButton *sex = [self viewWithTag:sender.tag==100?101:100];
    sex.selected = NO;
    sex.userInteractionEnabled = YES;
}

- (NSArray<HEBPCAModel *> *)pcaModelArr {
    if (!_pcaModelArr) {
        NSString *cityINFO = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
        _pcaModelArr = [NSArray yy_modelArrayWithClass:[HEBPCAModel class] json:cityINFO];
    }
    return _pcaModelArr;
}

@end
