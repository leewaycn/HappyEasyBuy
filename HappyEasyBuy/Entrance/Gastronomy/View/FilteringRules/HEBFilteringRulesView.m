//
//  HEBFilteringRulesView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/23.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBFilteringRulesView.h"

@interface HEBFilteringRulesView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBFilteringRulesView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableView.tag==100?self.netWorkingModelArr.count:self.localModelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
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
    
    cell.textLabel.text = (tableView.tag==100?self.netWorkingModelArr:self.localModelArr)[indexPath.row][@"name"];
    BOOL select = [(tableView.tag==100?self.netWorkingModelArr:self.localModelArr)[indexPath.row][@"select"] length];
    if (select) {
        UIImageView *img = [[UIImageView alloc] initWithImage:UIImageMake(@"选中")];
        [cell.contentView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.right.equalTo(cell.contentView.mas_right).offset(-15);
        }];
    }
    cell.dividingLine = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    NSMutableArray<NSDictionary *> *arrM = [NSMutableArray array];
    if (tableView.tag == 101) {
        [self.localModelArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
            [dictM setObject:obj[@"name"] forKey:@"name"];
            [dictM setObject:[NSString stringWithFormat:@"%ld", indexPath.row] forKey:@"objid"];
            [dictM setObject:idx==indexPath.row?@"Y":@"" forKey:@"select"];
            [arrM addObject:dictM];
        }];
    }else {
        [self.netWorkingModelArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
            [dictM setObject:obj[@"name"] forKey:@"name"];
            [dictM setObject:idx==indexPath.row?@"Y":@"" forKey:@"select"];
            [dictM setObject:obj[@"objid"] forKey:@"objid"];
            [arrM addObject:dictM];
        }];
    }
    if (self.getHeaderToolsDidClick) {
        self.getHeaderToolsDidClick(arrM, [arrM[indexPath.row][@"objid"] integerValue], arrM[indexPath.row][@"name"]);
    }
}

- (NSArray *)netWorkingModelArr {
    if (!_netWorkingModelArr) {
        _netWorkingModelArr = [NSArray array];
    }
    return _netWorkingModelArr;
}

- (NSArray *)localModelArr {
    if (!_localModelArr) {
        _localModelArr = [NSArray array];
    }
    return _localModelArr;
}

@end
