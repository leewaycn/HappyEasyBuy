//
//  HEBScreeningView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/18.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBScreeningView.h"

@interface HEBScreeningView()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) NSMutableDictionary *infoDictM;

@end

@implementation HEBScreeningView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    self.scrollEnabled = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?1:2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section==1&&indexPath.row==0?140:64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] init];
    QMUILabel *msg = [[QMUILabel alloc] init];
    msg.text = section==0?@"商家特色":@"人均价筛选";
    msg.font = UIFontMake(18);
    [header addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(header.mas_centerY);
        make.left.equalTo(header.mas_left).offset(20);
    }];
    return header;
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
    cell.contentView.qmui_borderPosition = QMUIBorderViewPositionBottom;
    cell.contentView.qmui_borderColor = UIColorHex(#efefef);
    cell.contentView.qmui_borderWidth = 1;
    __weak __typeof(self)weakSelf = self;
    if (indexPath.section == 0) {
        [self.shopCellModelArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            QMUIButton *sender = [[QMUIButton alloc] init];
            sender.tag = idx;
            sender.selected = [obj[@"select"] length];
            [sender setTitle:obj[@"msg"] forState:UIControlStateNormal>>UIControlStateSelected];
            [sender setTitleColor:BASEBLACK forState:UIControlStateNormal];
            [sender setTitleColor:UIColorWhite forState:UIControlStateSelected];
            sender.titleLabel.font = UIFontMake(14);
            sender.backgroundColor = [obj[@"select"] length]?BASECOLOR:UIColorWhite;
            sender.layer.cornerRadius = 15;
            sender.layer.masksToBounds = YES;
            sender.layer.borderColor = UIColorHex(#BDC7D8).CGColor;
            sender.layer.borderWidth = 1;
            [cell.contentView addSubview:sender];
            [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView.mas_centerY);
                make.size.mas_offset(CGSizeMake(SCREEN_WIDTH/3, 44));
                make.left.equalTo(cell.contentView.mas_left).offset(idx*(SCREEN_WIDTH/3)+(idx*15+15));
            }];
            [sender addBlockForControlEvents:UIControlEventTouchUpInside block:^(QMUIButton * _Nonnull sender) {
                NSMutableArray *arrM = [NSMutableArray array];
                [weakSelf.shopCellModelArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                    [dict setObject:obj[@"msg"] forKey:@"msg"];
                    [dict setObject:idx==sender.tag?([obj[@"select"] length]?@"":@"Y"):@"" forKey:@"select"];
                    [arrM addObject:dict];
                }];
                weakSelf.shopCellModelArr = arrM;
                if ([weakSelf.shopCellModelArr[sender.tag][@"select"] length]) {
                    [weakSelf.infoDictM setObject:obj[@"msg"] forKey:@"shop"];
                }else {
                    [weakSelf.infoDictM removeObjectForKey:@"shop"];
                }
                [tableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
            }];
        }];
    }else {
        if (indexPath.row == 0) {
            [self.moneyCellModelArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                QMUIButton *sender = [[QMUIButton alloc] init];
                sender.tag = idx;
                sender.selected = [obj[@"select"] length];
                [sender setTitle:obj[@"msg"] forState:UIControlStateNormal>>UIControlStateSelected];
                [sender setTitleColor:BASECOLOR forState:UIControlStateNormal];
                [sender setTitleColor:UIColorWhite forState:UIControlStateSelected];
                sender.titleLabel.font = UIFontMake(14);
                sender.backgroundColor = [obj[@"select"] length]?BASECOLOR:UIColorWhite;
                sender.layer.cornerRadius = 15;
                sender.layer.masksToBounds = YES;
                sender.layer.borderColor = UIColorHex(#BDC7D8).CGColor;
                sender.layer.borderWidth = 1;
                [cell.contentView addSubview:sender];
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (idx < 3) {
                        make.centerY.equalTo(cell.contentView.mas_centerY).multipliedBy(0.5);
                        make.left.equalTo(cell.contentView.mas_left).offset(idx*(SCREEN_WIDTH/4)+(idx*15+15));
                    }else {
                        make.centerY.equalTo(cell.contentView.mas_centerY).multipliedBy(1.5);
                    make.left.equalTo(cell.contentView.mas_left).offset((idx-3)*(SCREEN_WIDTH/4)+(idx*15+15));
                    }
                    make.size.mas_offset(CGSizeMake(SCREEN_WIDTH/4, 44));
                }];
                [sender addBlockForControlEvents:UIControlEventTouchUpInside block:^(QMUIButton * _Nonnull sender) {
                    NSMutableArray *arrM = [NSMutableArray array];
                    [weakSelf.moneyCellModelArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                        [dict setObject:obj[@"msg"] forKey:@"msg"];
                        [dict setObject:idx==sender.tag?([obj[@"select"] length]?@"":@"Y"):@"" forKey:@"select"];
                        [arrM addObject:dict];
                    }];
                    weakSelf.moneyCellModelArr = arrM;
                    if ([weakSelf.moneyCellModelArr[sender.tag][@"select"] length]) {
                        [weakSelf.infoDictM setObject:obj[@"msg"] forKey:@"money"];
                    }else {
                        [weakSelf.infoDictM removeObjectForKey:@"money"];
                    }
                    [tableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
                }];
            }];
        }else {
            QMUIButton *clean = [[QMUIButton alloc] init];
            [clean setTitle:@"清除筛选" forState:UIControlStateNormal];
            [clean setTitleColor:BASEBLACK forState:UIControlStateNormal];
            clean.titleLabel.font = UIFontMake(18);
            [cell.contentView addSubview:clean];
            [clean mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.equalTo(cell.contentView);
                make.width.mas_offset(SCREEN_WIDTH/3);
            }];
            [clean addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                [weakSelf.infoDictM removeAllObjects];
                weakSelf.infoDictM = nil;
                weakSelf.shopCellModelArr = nil;
                weakSelf.moneyCellModelArr = nil;
                [tableView reloadData];
            }];
            QMUIButton *submit = [[QMUIButton alloc] init];
            submit.backgroundColor = BASECOLOR;
            [submit setTitle:@"完成" forState:UIControlStateNormal];
            [submit setTitleColor:UIColorWhite forState:UIControlStateNormal];
            submit.titleLabel.font = UIFontMake(18);
            [cell.contentView addSubview:submit];
            [submit mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.right.equalTo(cell.contentView);
                make.width.mas_offset(SCREEN_WIDTH/4);
            }];
            [submit addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                if (weakSelf.getSelectScreeningINFO) {
                    weakSelf.getSelectScreeningINFO(weakSelf.infoDictM, weakSelf.shopCellModelArr, weakSelf.moneyCellModelArr);
                }
            }];
        }
    }
    return cell;
}

- (NSArray<NSDictionary *> *)shopCellModelArr {
    if (!_shopCellModelArr) {
        _shopCellModelArr = @[@{@"msg":@"免费配送", @"select":@""},
                              @{@"msg":@"新商家", @"select":@""}];
    }
    return _shopCellModelArr;
}

- (NSArray<NSDictionary *> *)moneyCellModelArr {
    if (!_moneyCellModelArr) {
        _moneyCellModelArr = @[@{@"msg":@"¥0-20", @"select":@""},
                               @{@"msg":@"¥20-50", @"select":@""},
                               @{@"msg":@"¥50-100", @"select":@""},
                               @{@"msg":@"¥100-200", @"select":@""},
                               @{@"msg":@"¥200-300+", @"select":@""}];
    }
    return _moneyCellModelArr;
}

- (NSMutableDictionary *)infoDictM {
    if (!_infoDictM) {
        _infoDictM = [NSMutableDictionary dictionary];
    }
    return _infoDictM;
}

@end
