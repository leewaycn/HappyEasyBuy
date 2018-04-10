//
//  HEBMerChantView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBMerChantView.h"
#import "HEBMerchantCell.h"
#import "HEBMerchantCateModel.h"
#import "HEBMerchantAddressModel.h"

@interface HEBMerChantView ()<QMUITableViewDataSource, QMUITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong) NSMutableArray<NSDictionary *> *cellModelArr;

/** 地址选择器 */
@property(nonatomic, strong) UIPickerView *addressPick;

/** 分类选择器 */
@property(nonatomic, strong) UIPickerView *catePick;

/** 城市数据源 */
@property(nonatomic, strong) NSMutableArray<NSArray <HEBMerchantAddressModel *> *> *addressModelArr;

/** 分类数据源 */
@property(nonatomic, strong) NSMutableArray<NSArray <HEBMerchantCateModel *>*> *cateModelArr;

/** 记录选择的分类id */
@property(nonatomic, copy) NSString *cateid;

@property(nonatomic, copy) NSString *addressStr;

/** 倒计时 */
@property(nonatomic, assign) int time;

@property(nonatomic, strong) NSMutableDictionary *params;

@property(nonatomic, assign) NSInteger af;

@property(nonatomic, assign) NSInteger as;

@property(nonatomic, assign) NSInteger al;

@property(nonatomic, assign) NSInteger sf;

@property(nonatomic, assign) NSInteger ss;

@end
    
@implementation HEBMerChantView

- (void)loadView {
    self.af = 0;
    self.as = 0;
    self.al = 0;
    self.sf = 0;
    self.ss = 0;
    self.time = 60;
    self.dataSource = self;
    self.delegate = self;
    self.dividingLine = YES;
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    QMUIButton *submit = [[QMUIButton alloc] init];
    submit.backgroundColor = BASECOLOR;
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    [submit setTitleColor:UIColorWhite forState:UIControlStateNormal];
    [foot addSubview:submit];
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(foot.mas_left).offset(20);
        make.right.equalTo(foot.mas_right).offset(-20);
        make.centerY.equalTo(foot.mas_centerY);
        make.height.mas_offset(44);
    }];
    submit.layer.cornerRadius = 10;
    submit.layer.masksToBounds = YES;
    self.tableFooterView = foot;
    [submit addTarget:self action:@selector(submitDidClick) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    HEBMerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HEBMerchantCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellINFO];
    cell.dividingLine = YES;
    NSDictionary *dict = self.cellModelArr[indexPath.row];
    cell.img.image = UIImageMake(dict[@"img"]);
    [cell.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.left.equalTo(cell.contentView.mas_left).offset(15);
        make.size.mas_offset(cell.img.image.size);
    }];
    __weak __typeof(self)weakSelf = self;
    cell.field.placeholder = dict[@"placeholder"];
    cell.field.tag = indexPath.row+100;
    cell.field.text = dict[@"content"];
    if ([dict[@"img"] isEqualToString:@"手机"]) {
        cell.field.keyboardType = UIKeyboardTypeNumberPad;
        cell.field.maximumTextLength = 11;
    }
    if ([dict[@"img"] isEqualToString:@"验证码"]) {
        cell.field.keyboardType = UIKeyboardTypePhonePad;
        QMUIButton *senMsg = [[QMUIButton alloc] init];
        senMsg.titleLabel.font = UIFontMake(14);
        [senMsg setTitle:@"获取验证码" forState:UIControlStateNormal];
        [senMsg setTitleColor:BASEBLACK forState:UIControlStateNormal];
        [cell.contentView addSubview:senMsg];
        [senMsg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.right.equalTo(cell.contentView.mas_right).offset(-10);
            make.height.equalTo(cell.contentView.mas_height).offset(-15);
            make.width.mas_offset(80);
        }];
        senMsg.layer.cornerRadius = 5;
        senMsg.layer.masksToBounds = YES;
        senMsg.layer.borderColor = UIColorHex(#e7e7e7).CGColor;
        senMsg.layer.borderWidth = 1;
        [cell.field mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(cell.contentView);
            make.left.equalTo(cell.img.mas_right).offset(10);
            make.right.equalTo(senMsg.mas_left).offset(-5);
        }];
        [senMsg addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            QMUIButton *btn = sender;
            HEBMerchantCell *cell = (id)[weakSelf cellForRow:0 inSection:0];
            if (cell.field.text.isMobNumber) {
                [Networking postUrl:SendINMessage params:@{@"phone":cell.field.text} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                    if (mainModel.status) {
                        btn.enabled = NO;
                        [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer * _Nonnull timer) {
                            if (weakSelf.time < 1) {
                                weakSelf.time = 60;
                                [timer invalidate];
                                timer = nil;
                                btn.enabled = YES;
                                [btn setTitle:@"重新获取" forState:UIControlStateNormal];
                            }else {
                                weakSelf.time = weakSelf.time - 1;
                                [btn setTitle:[NSString stringWithFormat:@"%d", weakSelf.time] forState:UIControlStateNormal];
                            }
                        } repeats:YES];
                    }
                }];
            }else {
                [ISMessages showCardAlertWithTitle:@"发送失败" message:@"请检查手机号是否正确" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
            }
        }];
    }
    [cell.field addBlockForControlEvents:UIControlEventEditingChanged block:^(id  _Nonnull sender) {
        QMUITextField *field = sender;
        NSDictionary *newDict = @{@"img":dict[@"img"], @"placeholder":dict[@"placeholder"], @"content":field.text};
        [weakSelf.cellModelArr replaceObjectAtIndex:indexPath.row withObject:newDict];
    }];
    if ([dict[@"img"] isEqualToString:@"详细地址"]) {
        UIPickerView *addressPick = [[UIPickerView alloc] init];
        selfClass(addressPick);
        addressPick.tag = indexPath.row;
        addressPick.delegate = self;
        addressPick.dataSource = self;
        cell.field.inputView = addressPick;
        [cell.field addBlockForControlEvents:UIControlEventEditingDidBegin block:^(id  _Nonnull sender) {
            [weakSelf loadNetworking:@{@"type":@"1"}];
        }];
    }
    if ([dict[@"img"] isEqualToString:@"店铺分类"]) {
        UIPickerView *catePick = [[UIPickerView alloc] init];
        selfClass(catePick);
        catePick.tag = indexPath.row;
        catePick.delegate = self;
        catePick.dataSource = self;
        cell.field.inputView = catePick;
        [cell.field addBlockForControlEvents:UIControlEventEditingDidBegin block:^(id  _Nonnull sender) {
            [weakSelf loadCateNetworking];
        }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView.tag == 4) {
        return self.addressModelArr.count;
    }
    return self.cateModelArr.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 4) {
        return self.addressModelArr[component].count;
    }
    return self.cateModelArr[component].count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView.tag == 4) {
        return self.addressModelArr[component][row].name;;
    }
    return self.cateModelArr[component][row].name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView.tag == 4) {
        HEBMerchantAddressModel *model = self.addressModelArr[component][row];
        if (component == 0) {
            self.af = row;
            self.as = 0;
            self.al = 0;
            self.addressStr = [NSString stringWithFormat:@"%@ ", model.name];
            [self loadNetworking:@{@"type":@"2", @"pid":model.objid}];
        }else if (component == 1) {
            self.as = row;
            self.al = 0;
            [self loadNetworking:@{@"type":@"3", @"pid":model.objid}];
            NSArray<NSString *> *arr = [self.addressStr componentsSeparatedByString:@" "];
            self.addressStr = [NSString stringWithFormat:@"%@ %@", arr.firstObject, model.name];
            [self.params setObject:model.objid forKey:@"city_id"];
        }else {
            self.al = row;
            NSArray<NSString *> *arr = [self.addressStr componentsSeparatedByString:@" "];
            self.addressStr = [NSString stringWithFormat:@"%@ %@ %@", arr.firstObject, arr[1], model.name];
            HEBMerchantCell *cell = (id)[self cellForRow:pickerView.tag inSection:0];
            cell.field.text = self.addressStr;
        }
    }else {
     HEBMerchantCateModel *model = self.cateModelArr[component][row];
    if (component == 0) {
        self.sf = row;
        self.ss = 0;
        self.cateid = model.cateid;
        [self loadCateNetworking];
    }else {
        self.ss = row;
    }
    HEBMerchantCell *cell = (id)[self cellForRow:pickerView.tag inSection:0];
    cell.field.text = model.name;
        [self.params setObject:model.cateid forKey:@"cate_id"];
    }
}

- (void)loadNetworking:(NSDictionary *)params {
    [self.viewControl.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:CityList params:params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf.viewControl dismissProgressHUD];
        if (mainModel.status) {
            if ([params[@"type"] isEqualToString:@"1"]) {
                    [weakSelf.addressModelArr removeAllObjects];
                    [weakSelf.addressModelArr addObject:[NSArray yy_modelArrayWithClass:[HEBMerchantAddressModel class] json:mainModel.data]];
                [weakSelf loadNetworking:@{@"type":@"2", @"pid":weakSelf.addressModelArr.firstObject.firstObject.objid}];
            }else if ([params[@"type"] isEqualToString:@"2"]) {
                if (weakSelf.addressModelArr.count >= 2) {
                    [weakSelf.addressModelArr removeObjectAtIndex:1];
                    [weakSelf.addressModelArr removeLastObject];
                    [weakSelf.addressModelArr addObject:[NSArray yy_modelArrayWithClass:[HEBMerchantAddressModel class] json:mainModel.data]];
                }else {
                    [weakSelf.addressModelArr addObject:[NSArray yy_modelArrayWithClass:[HEBMerchantAddressModel class] json:mainModel.data]];
                }
                [weakSelf loadNetworking:@{@"type":@"3", @"pid":weakSelf.addressModelArr[1].firstObject.objid}];
            }else if ([params[@"type"] isEqualToString:@"3"]) {
                if (weakSelf.addressModelArr.count == 3) {
                    [weakSelf.addressModelArr replaceObjectAtIndex:2 withObject:[NSArray yy_modelArrayWithClass:[HEBMerchantAddressModel class] json:mainModel.data]];
                }else {
                    [weakSelf.addressModelArr addObject:[NSArray yy_modelArrayWithClass:[HEBMerchantAddressModel class] json:mainModel.data]];
                }
                QMUITextField *field = [weakSelf viewWithTag:104];
                field.text = [NSString stringWithFormat:@"%@ %@ %@",
                              self.addressModelArr[0][self.af].name,
                              self.addressModelArr[1][self.as].name,
                              self.addressModelArr[2][self.al].name];
                [self.params setObject:self.addressModelArr[1][self.as].objid forKey:@"city_id"];
            }
            [weakSelf.addressPick reloadAllComponents];
        }
    }];
}

- (void)loadCateNetworking {
    [self.viewControl.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:GetMerchantCate params:self.cateid?@{@"id":self.cateid, @"city_id":getCity_id}:nil callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf.viewControl dismissProgressHUD];
        if (mainModel.status) {
            if (weakSelf.cateid && weakSelf.cateModelArr.count == 2) {
                [weakSelf.cateModelArr replaceObjectAtIndex:1 withObject:[NSArray yy_modelArrayWithClass:[HEBMerchantCateModel class] json:mainModel.data]];
            }else {
                [weakSelf.cateModelArr addObject:[NSArray yy_modelArrayWithClass:[HEBMerchantCateModel class] json:mainModel.data]];
            }
        }else {
            if (weakSelf.cateModelArr.count == 2) {
                [weakSelf.cateModelArr removeObjectAtIndex:1];
            }
        }
        if (!weakSelf.cateid) {
            weakSelf.cateid = weakSelf.cateModelArr[0][0].cateid;
            [weakSelf loadCateNetworking];
        }
         QMUITextField *field = [weakSelf viewWithTag:106];
        if (weakSelf.cateModelArr.count == 1) {
            field.text = weakSelf.cateModelArr[0][weakSelf.sf].name;
            [self.params setObject:weakSelf.cateModelArr[0][weakSelf.sf].cateid forKey:@"cate_id"];
        }else {
            field.text = weakSelf.cateModelArr[1][weakSelf.ss].name;
            [self.params setObject:weakSelf.cateModelArr[1][weakSelf.ss].cateid forKey:@"cate_id"];
        }
        [weakSelf.catePick reloadAllComponents];
    }];
}

- (NSMutableArray<NSDictionary *> *)cellModelArr {
    if (!_cellModelArr) {
        _cellModelArr = [NSMutableArray arrayWithArray:@[@{@"img":@"手机", @"placeholder":@"请输入手机号", @"content":@""},
                                                         @{@"img":@"验证码", @"placeholder":@"请输入验证码", @"content":@""},
                                                         @{@"img":@"联系人", @"placeholder":@"联系人", @"content":@""},
                                                         @{@"img":@"店铺", @"placeholder":@"店铺", @"content":@""},
                                                         @{@"img":@"详细地址", @"placeholder":@"请选择详细地址", @"content":@""},
                                                         @{@"img":@"邮箱", @"placeholder":@"邮箱 如: 88888@qq.com", @"content":@""},
                                                         @{@"img":@"店铺分类", @"placeholder":@"请选择店铺分类", @"content":@""}]];
    }
    return _cellModelArr;
}

- (void)submitDidClick {
    for (int i = 100; i < 107; i ++) {
        QMUITextField *field = [self viewWithTag:i];
        if (!field.hasText) {
            [ISMessages showCardAlertWithTitle:@"提交失败" message:@"请将信息填写完整" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
            return;
        }
    }
    [self.params setObject:[self getFieldText:100] forKey:@"phone"];
    [self.params setObject:[self getFieldText:101] forKey:@"verify"];
    [self.params setObject:[self getFieldText:102] forKey:@"name"];
    [self.params setObject:[self getFieldText:103] forKey:@"shopname"];
    [self.params setObject:[self getFieldText:104] forKey:@"address"];
    [self.params setObject:[self getFieldText:105] forKey:@"email"];
    [self.viewControl.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:SubmitSHOPINFO params:self.params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf.viewControl dismissProgressHUD];
        if (mainModel.status) {
            [weakSelf.viewControl.navigationController popViewControllerAnimated:YES];
        }else {
            [ISMessages showCardAlertWithTitle:@"提交失败" message:mainModel.msg duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
        }
    }];
}

- (NSString *)getFieldText:(NSInteger)tag {
    QMUITextField *field = [self viewWithTag:tag];
    return field.text;
}

- (NSMutableArray *)addressModelArr {
    if (!_addressModelArr) {
        _addressModelArr = [NSMutableArray array];
    }
    return _addressModelArr;
}

- (NSMutableArray<NSArray<HEBMerchantCateModel *> *> *)cateModelArr {
    if (!_cateModelArr) {
        _cateModelArr = [NSMutableArray array];
    }
    return _cateModelArr;
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
        [_params setObject:getUser_id forKey:@"uid"];
    }
    return _params;
}

@end
