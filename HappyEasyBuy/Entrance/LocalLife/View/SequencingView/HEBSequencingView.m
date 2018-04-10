//
//  HEBScreeningView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBSequencingView.h"

@interface HEBSequencingView ()<QMUITableViewDelegate, QMUITableViewDataSource, UIScrollViewDelegate>


@end

@implementation HEBSequencingView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    self.scrollEnabled = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    cell.contentView.qmui_borderPosition = QMUIBorderViewPositionBottom;
    cell.contentView.qmui_borderColor = UIColorHex(#efefef);
    cell.contentView.qmui_borderWidth = 1;
    NSDictionary *dict = self.cellModelArr[indexPath.row];
    NSString *imgName = [dict[@"select"] length]?[NSString stringWithFormat:@"%@_选中", dict[@"img"]]:dict[@"img"];
    UIImageView *img = [[UIImageView alloc] initWithImage:UIImageMake(imgName)];
    [cell.contentView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.left.equalTo(cell.contentView.mas_left).offset(15);
    }];
    
    QMUILabel *msg = [[QMUILabel alloc] init];
    msg.text = dict[@"img"];
    msg.textColor = [dict[@"select"] length]?BASECOLOR:UIColorHex(#878787);
    msg.font = UIFontMake(14);
    [cell.contentView addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(img.mas_centerY);
        make.left.equalTo(img.mas_right).offset(15);
    }];
    
    UIImageView *select = [[UIImageView alloc] initWithImage:UIImageMake(@"选中")];
    select.hidden = ![dict[@"select"] length];
    [cell.contentView addSubview:select];
    [select mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(msg.mas_centerY);
        make.right.equalTo(cell.contentView.mas_right).offset(-15);
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    NSMutableArray *modelArrM = [NSMutableArray array];
    [self.cellModelArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
        if (idx == indexPath.row) {
            [dictM setObject:@"Y" forKey:@"select"];
        }else {
            [dictM setObject:@"" forKey:@"select"];
        }
        [dictM setObject:obj[@"img"] forKey:@"img"];
        [modelArrM addObject:dictM];
    }];
    self.cellModelArr = modelArrM;
    if (self.changeCellModelArr) {
        self.changeCellModelArr(self.cellModelArr, indexPath.row);
    }
    [tableView reloadData];
}

- (NSArray<NSDictionary *> *)cellModelArr {
    if (!_cellModelArr) {
        _cellModelArr = [NSArray array];
    }
    return _cellModelArr;
}

@end
