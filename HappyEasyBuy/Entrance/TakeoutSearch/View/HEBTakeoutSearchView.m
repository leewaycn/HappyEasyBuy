//
//  HEBTakeoutSearchView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/10.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBTakeoutSearchView.h"
#import "HEBGuessYlikeView.h"
#import "HEBTakOutDetailViewController.h"

@interface HEBTakeoutSearchView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBTakeoutSearchView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchModelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
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
    HEBGuessYlikeView *guessYlikeView = [[HEBGuessYlikeView alloc] init];
    cell.dividingLine = YES;
    [guessYlikeView cellforGuessYlikeModel:self.searchModelArr[indexPath.row]];
    [cell.contentView addSubview:guessYlikeView];
    [guessYlikeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    HEBTakOutDetailViewController *takeOut = [[HEBTakOutDetailViewController alloc] init];
    takeOut.shop_id = self.searchModelArr[indexPath.row].objid;
    [self.viewController.navigationController pushViewController:takeOut animated:YES];
}

- (NSArray<HEBGuessYlikeModel *> *)searchModelArr {
    if (!_searchModelArr) {
        _searchModelArr = [NSArray array];
    }
    return _searchModelArr;
}

@end
