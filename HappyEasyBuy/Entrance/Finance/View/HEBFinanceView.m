//
//  HEBFinanceView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBFinanceView.h"
#import "HEBFinanceCell.h"
#import "HEBFinanceDetailViewController.h"
#import <YYLabel.h>

@interface HEBFinanceView ()<QMUITableViewDataSource, QMUITableViewDelegate>

@end

@implementation HEBFinanceView

- (void)loadView {
    HEBFinanceHeaderView *headerView = [[HEBFinanceHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    selfClass(headerView);
    self.tableHeaderView = headerView;
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.financeModelArrM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] init];
    YYTextSimpleEmoticonParser *parser = [[YYTextSimpleEmoticonParser alloc] init];
    parser.emoticonMapper = @{@"finance":UIImageMake(@"理财产品")};
    YYLabel *lab= [[YYLabel alloc] init];
    lab.backgroundColor = UIColorWhite;
    lab.font = UIFontMake(14);
    lab.textColor = BASEBLACK;
    lab.textParser = parser;
    lab.text = @"    finance 理财产品";
    [header addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header.mas_top).offset(10);
        make.bottom.equalTo(header);
        make.left.right.equalTo(header);
    }];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    HEBFinanceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HEBFinanceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    HEBFinanceModel *model = self.financeModelArrM[indexPath.row];
    [cell setCellINFO];
    cell.dividingLine = YES;
    cell.percentage.text = [NSString stringWithFormat:@"%@%%", model.f_rate];
    cell.SPercentage.text = model.f_rate1;
    cell.describe.text = model.f_desc;
    cell.SDescribe.text = model.f_desc1;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    HEBFinanceModel *model = self.financeModelArrM[indexPath.row];
    HEBFinanceDetailViewController *detail = [[HEBFinanceDetailViewController alloc] init];
    detail.title = model.f_name;
    detail.objid = model.f_id;
    [self.viewControl.navigationController pushViewController:detail animated:YES];
}

- (NSMutableArray<HEBFinanceModel *> *)financeModelArrM {
    if (!_financeModelArrM) {
        _financeModelArrM = [NSMutableArray array];
    }
    return _financeModelArrM;
}

@end
