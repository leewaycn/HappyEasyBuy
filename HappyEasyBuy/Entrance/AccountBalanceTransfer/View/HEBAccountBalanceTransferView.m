//
//  HEBAccountBalanceTransferView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/11.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBAccountBalanceTransferView.h"
#import "HEBAccountBalanceTransferHeaderView.h"

@interface HEBAccountBalanceTransferView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) HEBAccountBalanceTransferHeaderView *headerView;

/** 用户是否存在 */
@property(nonatomic, assign) BOOL hasUser;

@property(nonatomic, strong) NSMutableArray<NSString *> *sectionStr;

@property(nonatomic, strong) NSArray<NSDictionary *> *payType;

@property(nonatomic, assign) NSInteger payTag;

/** 支付按钮 */
@property(nonatomic, strong) QMUIButton *pay;

/** 支付金额 */
@property(nonatomic, copy) NSString *money;

/** 限制 */
@property(nonatomic, copy) NSString *limit;

@property(nonatomic, copy) NSString *user;

@end

@implementation HEBAccountBalanceTransferView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    self.payTag = 0;
    HEBAccountBalanceTransferHeaderView *headerView = [[HEBAccountBalanceTransferHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    selfClass(headerView);
    [headerView.validation addTarget:self action:@selector(validationDidClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView.mobNumber addBlockForControlEvents:UIControlEventEditingChanged block:^(id  _Nonnull sender) {
        self.hasUser = NO;
        self.pay.enabled = NO;
    }];
    self.tableHeaderView = headerView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionStr.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?1:section==1?self.payType.count:1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section < self.sectionStr.count && self.sectionStr.count) {
        UIView *header = [[UIView alloc] init];
        QMUILabel *lab = [[QMUILabel alloc] init];
        lab.text = self.sectionStr[section];
        lab.textColor = BASEBLACK;
        [header addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(header.mas_left).offset(15);
            make.bottom.equalTo(header.mas_bottom).offset(-2);
        }];
        return header;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == self.sectionStr.count) {
        cell.backgroundColor = UIColorClear;
        QMUIButton *pay = [[QMUIButton alloc] init];
        pay.tag = self.payTag;
        selfClass(pay);
        [pay setTitleColor:UIColorWhite forState:UIControlStateNormal];
        [pay setTitle:@"确定" forState:UIControlStateNormal];
        [pay addTarget:self action:@selector(payDidClick:) forControlEvents:UIControlEventTouchUpInside];
        pay.titleLabel.font = UIFontMake(18);
        pay.backgroundColor = BASECOLOR;
        pay.enabled = self.hasUser;
        pay.layer.cornerRadius = 5;
        pay.layer.masksToBounds = YES;
        [cell.contentView addSubview:pay];
        [pay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.contentView.mas_centerX);
            make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 44));
        }];
    }else if (indexPath.section == 0) {
        cell.dividingLine = YES;
        cell.backgroundColor = UIColorWhite;
        QMUITextField *money = [[QMUITextField alloc] init];
        money.tail = YES;
        money.text = self.money;
        [money addBlockForControlEvents:UIControlEventEditingChanged block:^(id  _Nonnull sender) {
            QMUITextField *field = sender;
            self.money = field.text;
        }];
        money.clearButtonMode = UITextFieldViewModeWhileEditing;
        money.placeholder = @"请输入转账金额";
        [cell.contentView addSubview:money];
        [money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }else {
        cell.dividingLine = YES;
        UIImageView *img = [[UIImageView alloc] initWithImage:UIImageMake(self.payType[indexPath.row][@"title"])];
        [cell.contentView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).offset(15);
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.size.mas_offset(img.image.size);
        }];
        
        QMUILabel *title = [[QMUILabel alloc] init];
        title.font = UIFontMake(16);
        title.text = self.payType[indexPath.row][@"title"];
        [cell.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(img.mas_centerY);
            make.left.equalTo(img.mas_right).offset(20);
        }];
        
        NSString *imgName = [self.payType[indexPath.row][@"select"] length]?@"支付方式选中":@"支付方式未选中";
        UIImageView *select = [[UIImageView alloc] initWithImage:UIImageMake(imgName)];
        [cell.contentView addSubview:select];
        [select mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.right.equalTo(cell.contentView.mas_right).offset(-15);
            make.size.mas_offset(select.image.size);
        }];
    }
    return cell;
}

- (void)payDidClick:(QMUIButton *)sender {
    if (self.money.doubleValue > self.limit.doubleValue || !self.money.length) {
        [ISMessages showCardAlertWithTitle:@"转账失败" message:@"输入金额有误，请重新输入" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
    }else {
        if (self.getPayType) {
            self.getPayType(sender.tag, self.money, self.user);
        }
    }
    NSLog(@"%ld----%@----%@", sender.tag, self.money, self.limit);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    if (indexPath.section) {
        NSMutableArray *arr = [NSMutableArray array];
        [self.payType enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:obj[@"title"] forKey:@"title"];
            [dict setObject:idx==indexPath.row?@"Y":@"" forKey:@"select"];
            [arr addObject:dict];
        }];
        self.pay.tag = indexPath.row;
        self.payTag = indexPath.row;
        self.payType = arr;
        [tableView reloadData];
    }
}

- (void)validationDidClick {
    if (self.headerView.mobNumber.text.isMobNumber) {
        __weak __typeof(self)weakSelf = self;
        [self.viewControl.progressHUD showAnimated:YES];
        [Networking postUrl:ValidationTransferUser params:@{@"phone":self.headerView.mobNumber.text} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
            [weakSelf.viewControl dismissProgressHUD];
            weakSelf.hasUser = mainModel.status;
            weakSelf.user = mainModel.data[@"id"];
            if (!mainModel.status) {
                [ISMessages showCardAlertWithTitle:@"验证失败" message:mainModel.msg duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
            }
            weakSelf.pay.enabled = mainModel.status;
        }];
    }else {
        [ISMessages showCardAlertWithTitle:@"验证失败" message:@"请检查用户账号是否正确" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
    }
}

- (NSMutableArray<NSString *> *)sectionStr {
    if (!_sectionStr) {
        _sectionStr = [NSMutableArray array];
        [Networking postUrl:TransferLimit params:@{@"vipid":getUser_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
            if (mainModel.status) {
                self.limit = mainModel.data;
                [_sectionStr addObject:[NSString stringWithFormat:@"今日还可转账%@元", mainModel.data]];
                [_sectionStr addObject:@"转账方式"];
            }
            [self reloadData];
        }];
    }
    return _sectionStr;
}

- (NSArray<NSDictionary *> *)payType {
    if (!_payType) {
        _payType = @[@{@"title":@"微信支付", @"select":@"Y"},
                    @{@"title":@"支付宝支付", @"select":@""},
                    @{@"title":@"余额支付", @"select":@""},];
    }
    return _payType;
}

@end
