//
//  HEBOrderIntegratedDetailView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderIntegratedDetailView.h"

@interface HEBOrderIntegratedDetailView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBOrderIntegratedDetailView

- (void)loadView {
    HEBOrderIntegratedDetailHeaderView *headerView = [[HEBOrderIntegratedDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    selfClass(headerView);
    self.tableHeaderView = headerView;
    self.delegate = self;
    self.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.integratedModel?2:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?3:2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section==1&&indexPath.row==0?80:34;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0?40:10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *header = [[UIView alloc] init];
        QMUILabel *msg = [[QMUILabel alloc] init];
        msg.backgroundColor = UIColorWhite;
        msg.text = @"  地址";
        msg.font = UIFontMake(18);
        [header addSubview:msg];
        [msg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(header.mas_centerY);
            make.top.equalTo(header.mas_top).offset(10);
            make.bottom.equalTo(header.mas_bottom);
            make.left.right.equalTo(header);
        }];
        msg.bottomLine = YES;
        return header;
    }
    return nil;
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
    cell.userInteractionEnabled = NO;
    if (indexPath.section == 0) {
        NSArray <NSString *>*arr = @[self.integratedModel.name, self.integratedModel.phone, self.integratedModel.address];
       cell.textLabel.text = arr[indexPath.row];
    }else {
        if (indexPath.row == 0) {
            cell.bottomLine = YES;
            UIImageView *img = [[UIImageView alloc] init];
            [img yy_setImageWithURL:[NSURL URLWithString:self.integratedModel.pic] options:YYWebImageOptionProgressive];
            [cell.contentView addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView.mas_centerY);
                make.left.equalTo(cell.contentView.mas_left).offset(25);
                make.size.equalTo(cell.contentView.mas_height).offset(-10);
            }];
            img.layer.cornerRadius = 70/2;
            img.layer.masksToBounds = YES;
            QMUILabel *name = [[QMUILabel alloc] init];
            name.text = self.integratedModel.title;
            name.font = UIFontMake(16);
            name.textColor = BASEBLACK;
            [cell.contentView addSubview:name];
            [name mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(img.mas_right).offset(15);
                make.top.equalTo(img.mas_top).offset(5);
            }];
            
            QMUILabel *money = [[QMUILabel alloc] init];
            money.font = UIFontMake(16);
            money.textColor = BASEBLACK;
            money.text = [NSString stringWithFormat:@"%@积分", self.integratedModel.integral];
            [cell.contentView addSubview:money];
            [money mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(img.mas_centerY);
                make.left.equalTo(name.mas_left);
            }];
        }else {
            QMUILabel *msg = [[QMUILabel alloc] init];
            msg.textColor = BASEBLACK;
            msg.font = UIFontMake(16);
            msg.text = [NSString stringWithFormat:@"快递: %@      单号:%@", self.integratedModel.ex_name, self.integratedModel.ex_odd];
            [cell.contentView addSubview:msg];
            [msg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView.mas_centerY);
                make.left.equalTo(cell.contentView.mas_left).offset(15);
            }];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

@end
