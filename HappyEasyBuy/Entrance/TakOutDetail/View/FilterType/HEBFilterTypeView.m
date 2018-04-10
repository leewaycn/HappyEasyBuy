//
//  HEBFilterTypeView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/8.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBFilterTypeView.h"

@interface HEBFilterTypeView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBFilterTypeView

- (void)loadView {
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
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.bottomLine = YES;
    cell.contentView.backgroundColor = UIColorHex(#f1f1f1);
    cell.selectedBackgroundView.backgroundColor = UIColorWhite;
    QMUILabel *msg = [[QMUILabel alloc] init];
    msg.text = self.cellModelArr[indexPath.row];
    msg.textColor = BASEBLACK;
    [cell.contentView addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(cell.contentView);
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.getFilterType) {
        self.getFilterType(indexPath.row, self.cellModelArr[indexPath.row]);
    }
}

- (UIImage *)cd_noDataViewImage {
    return nil;
}

- (NSArray<NSString *> *)cellModelArr {
    if (!_cellModelArr) {
        _cellModelArr = [NSArray array];
    }
    return _cellModelArr;
}

@end
