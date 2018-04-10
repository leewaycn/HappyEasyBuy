//
//  HEBOrderPayView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderPayView.h"

@interface HEBOrderPayView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) NSArray<NSDictionary *> *cellModelArr;

@end

@implementation HEBOrderPayView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    HEBOrderPayHeaderView *header = [[HEBOrderPayHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    header.dividingLine = YES;
    selfClass(header);
    self.tableHeaderView = header;
    
    QMUIButton *pay = [[QMUIButton alloc] init];
    pay.tag = 0;
    selfClass(pay);
    [pay setTitleColor:UIColorWhite forState:UIControlStateNormal];
    pay.titleLabel.font = UIFontMake(18);
    pay.backgroundColor = BASECOLOR;
    pay.layer.cornerRadius = 5;
    pay.layer.masksToBounds = YES;
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    self.tableFooterView = foot;
    [foot addSubview:pay];
    [pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(foot.mas_centerX);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 44));
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellModelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
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
    cell.bottomLine = indexPath.row!=self.cellModelArr.count-1?YES:NO;
    UIImageView *img = [[UIImageView alloc] initWithImage:UIImageMake(self.cellModelArr[indexPath.row][@"title"])];
    [cell.contentView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).offset(15);
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.size.mas_offset(img.image.size);
    }];
    
    QMUILabel *title = [[QMUILabel alloc] init];
    title.font = UIFontMake(16);
    title.text = self.cellModelArr[indexPath.row][@"title"];
    [cell.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(img.mas_centerY);
        make.left.equalTo(img.mas_right).offset(20);
    }];
    
    NSString *imgName = [self.cellModelArr[indexPath.row][@"select"] length]?@"支付方式选中":@"支付方式未选中";
    UIImageView *select = [[UIImageView alloc] initWithImage:UIImageMake(imgName)];
    [cell.contentView addSubview:select];
    [select mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.right.equalTo(cell.contentView.mas_right).offset(-15);
        make.size.mas_offset(select.image.size);
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    NSMutableArray *arr = [NSMutableArray array];
    [self.cellModelArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:obj[@"title"] forKey:@"title"];
        [dict setObject:idx==indexPath.row?@"Y":@"" forKey:@"select"];
        [arr addObject:dict];
    }];
    self.cellModelArr = arr;
    [tableView reloadData];
    self.pay.tag = indexPath.row;
}

- (NSArray<NSDictionary *> *)cellModelArr {
    if (!_cellModelArr) {
        if (self.hasTitle) {
            _cellModelArr = @[@{@"title":@"微信支付", @"select":@"Y"},
                              @{@"title":@"支付宝支付", @"select":@""},
                              @{@"title":@"余额支付", @"select":@""},];
        }else {
        _cellModelArr = @[@{@"title":@"微信支付", @"select":@"Y"},
                          @{@"title":@"支付宝支付", @"select":@""},
                          @{@"title":@"余额支付", @"select":@""},
                          @{@"title":@"乐享币支付", @"select":@""},];
        }
    }
    return _cellModelArr;
}

@end
