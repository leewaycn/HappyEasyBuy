//
//  HEBPayPasswordView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/3.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBPayPasswordView.h"

@interface HEBPayPasswordView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBPayPasswordView

- (void)loadView {
    self.backgroundColor = UIColorWhite;
    HEBPayPasswordHeaderView *headerView = [[HEBPayPasswordHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    selfClass(headerView);
    self.tableHeaderView = headerView;
    self.delegate = self;
    self.dataSource = self;
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    QMUIButton *pay = [[QMUIButton alloc] init];
    selfClass(pay);
    pay.backgroundColor = BASECOLOR;
    [pay setTitle:@"立即支付" forState:UIControlStateNormal];
    [pay setTitleColor:UIColorWhite forState:UIControlStateNormal];
    [foot addSubview:pay];
    [pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(foot.mas_bottom);
        make.left.equalTo(foot.mas_left).offset(15);
        make.right.equalTo(foot.mas_right).offset(-15);
        make.height.mas_offset(44);
    }];
    pay.layer.cornerRadius = 10;
    pay.layer.masksToBounds = YES;
    self.tableFooterView = foot;
    
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
    cell.bottomLine = YES;
    cell.detailTextLabel.text = dict[@"content"];
    return cell;
}

- (NSArray<NSDictionary *> *)cellModelArr {
    if (!_cellModelArr) {
        _cellModelArr = [NSArray array];
    }
    return _cellModelArr;
}

@end
