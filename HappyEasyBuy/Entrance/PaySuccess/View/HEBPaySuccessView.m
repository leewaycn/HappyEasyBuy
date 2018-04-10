//
//  HEBPaySuccessView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/4.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBPaySuccessView.h"

@interface HEBPaySuccessView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBPaySuccessView

- (void)loadView {
    self.dividingLine = YES;
    HEBPaySuccessHeaderView *headerView = [[HEBPaySuccessHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    selfClass(headerView);
    self.tableHeaderView = headerView;
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.userInteractionEnabled = NO;
    NSDictionary *dict = self.cellModelArr[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.textLabel.textColor = BASEBLACK;
    cell.detailTextLabel.text = dict[@"msg"];
    cell.detailTextLabel.textColor = BASEBLACK;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (NSArray<NSDictionary *> *)cellModelArr {
    if (!_cellModelArr) {
        _cellModelArr = [NSArray array];
    }
    return _cellModelArr;
}

@end
