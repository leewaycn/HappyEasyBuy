//
//  HEBVicinityView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBVicinityView.h"
#import "HEBTakOutDetailViewController.h"

@interface HEBVicinityView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBVicinityView

- (void)loadView {
    [self loadToolsView];
    [self loadTableView];
}

- (void)loadToolsView {
    __weak __typeof(self)weakSelf = self;
    HEBGuessYlikeHeaderView *toolsView = [[HEBGuessYlikeHeaderView alloc] init];
    selfClass(toolsView);
    toolsView.lab = @"附近商家";
    [toolsView loadHeaderView];
    [self addSubview:toolsView];
    [toolsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_offset(80);
    }];
    toolsView.guessYlikeHeaderViewDidClick = ^(QMUIButton *sender) {
        if (weakSelf.sequencingView) {
            [weakSelf.sequencingView removeFromSuperview];
            weakSelf.sequencingView = nil;
            if (sender.tag == 100) {
                return ;
            }
        }
        if (weakSelf.screeningView) {
            [weakSelf.screeningView removeFromSuperview];
            weakSelf.screeningView = nil;
            if (sender.tag == 103) {
                return;
            }
        }
        if (sender.tag != 101 && sender.tag != 102) {
                [weakSelf loadScreeningViewWithBtn:sender];
            return;
        }
        if (weakSelf.getguessYlikeDidClick) {
            weakSelf.getguessYlikeDidClick(sender);
        }
    };
}

- (void)loadTableView {
    QMUITableView *tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
     tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    selfClass(tableView);
    [self addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.toolsView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellModelArrM.count;
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
    [guessYlikeView cellforGuessYlikeModel:self.cellModelArrM[indexPath.row]];
    [cell.contentView addSubview:guessYlikeView];
    [guessYlikeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    HEBTakOutDetailViewController *takeOut = [[HEBTakOutDetailViewController alloc] init];
    takeOut.shop_id = self.cellModelArrM[indexPath.row].objid;
    [self.viewController.navigationController pushViewController:takeOut animated:YES];
}

- (void)loadScreeningViewWithBtn:(QMUIButton *)sender {
    __weak __typeof(self)weakSelf = self;
    if (sender.tag == 100) {
        HEBSequencingView *sequencingView = [[HEBSequencingView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        sequencingView.changeCellModelArr = ^(NSArray *cellModelArr, NSInteger idx) {
            if (weakSelf.getScreeningDidClick) {
                weakSelf.getScreeningDidClick(idx);
            }
            weakSelf.sequencingCellModelArr = cellModelArr;
            [sender setTitle:cellModelArr[idx][@"img"] forState:UIControlStateNormal];
            [weakSelf.sequencingView removeFromSuperview];
            weakSelf.sequencingView = nil;
        };
        selfClass(sequencingView);
        sequencingView.backgroundColor = UIColorWhite;
        sequencingView.cellModelArr = self.sequencingCellModelArr;
        [self addSubview:sequencingView];
        [sequencingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.toolsView.mas_bottom).offset(-5);
            make.left.right.bottom.equalTo(self);
        }];
        [sequencingView updateConstraintsIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            [sequencingView layoutIfNeeded];
        }];
    }else {
        HEBScreeningView *screeningView = [[HEBScreeningView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        NSLog(@"%@", self.shopCellModelArr);
        screeningView.shopCellModelArr = self.shopCellModelArr;
        screeningView.moneyCellModelArr = self.moneyCellModelArr;
        selfClass(screeningView);
        screeningView.backgroundColor = UIColorHex(#f1f1f1);
        [self.window addSubview:screeningView];
        [screeningView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.toolsView.mas_bottom).offset(-5);
            make.left.right.bottom.equalTo(self);
        }];
        [screeningView updateConstraintsIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            [screeningView layoutIfNeeded];
        }];
        screeningView.getSelectScreeningINFO = ^(NSDictionary *selectINFO, NSArray *shopCellModelArr, NSArray *moneyCellModelArr) {
            weakSelf.shopCellModelArr = shopCellModelArr;
            weakSelf.moneyCellModelArr = moneyCellModelArr;
            if (weakSelf.getSelectScreeningINFO) {
                weakSelf.getSelectScreeningINFO(selectINFO);
            }
            [weakSelf.screeningView removeFromSuperview];
            weakSelf.screeningView = nil;
        };
    }
    
}

- (NSMutableArray<HEBGuessYlikeModel *> *)cellModelArrM {
    if (!_cellModelArrM) {
        _cellModelArrM = [NSMutableArray array];
    }
    return _cellModelArrM;
}

- (NSArray *)sequencingCellModelArr {
    if (!_sequencingCellModelArr) {
        _sequencingCellModelArr = @[@{@"img":@"综合排序", @"select":@"Y"},
                                    @{@"img":@"评分最高", @"select":@""},
                                    @{@"img":@"起送价最低", @"select":@""},
                                    @{@"img":@"配送费最低", @"select":@""},
                                    @{@"img":@"人均高到低", @"select":@""},
                                    @{@"img":@"人均低到高", @"select":@""}];
    }
    return _sequencingCellModelArr;
}

- (NSArray *)shopCellModelArr {
    if (!_shopCellModelArr) {
        _shopCellModelArr = @[@{@"msg":@"免费配送", @"select":@""},
                              @{@"msg":@"新商家", @"select":@""}];
    }
    return _shopCellModelArr;
}

- (NSArray *)moneyCellModelArr {
    if (!_moneyCellModelArr) {
        _moneyCellModelArr = @[@{@"msg":@"¥0-20", @"select":@""},
                               @{@"msg":@"¥20-50", @"select":@""},
                               @{@"msg":@"¥50-100", @"select":@""},
                               @{@"msg":@"¥100-200", @"select":@""},
                               @{@"msg":@"¥200-300+", @"select":@""}];
    }
    return _moneyCellModelArr;
}

@end
