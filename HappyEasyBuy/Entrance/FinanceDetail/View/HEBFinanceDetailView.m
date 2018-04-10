//
//  HEBFinanceDetailView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBFinanceDetailView.h"

@interface HEBFinanceDetailView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBFinanceDetailView

- (void)loadView {
    HEBCycleScrollView *headerView = [[HEBCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.3)];
    [headerView startLocationCycleScrollViewType:@"1"];
    self.tableHeaderView = headerView;
    NSString *msgStr = @"    风险提示: 货币基金不等于银行存款，不保证最低收益或一定盈利";
    QMUILabel *msg = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, msgStr.heightWith14_30)];
    msg.textAlignment = NSTextAlignmentCenter;
    msg.numberOfLines = 0;
    msg.text = msgStr;
    msg.textColor = UIColorGray;
    msg.font = UIFontMake(14);
    self.tableFooterView = msg;
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model?3:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section==0?[self.model.f_name heightForFont:UIFontMake(24) width:SCREEN_WIDTH-30]+[self.model.f_desc heightForFont:UIFontMake(16) width:SCREEN_WIDTH-30]+[self.model.f_desc2 heightForFont:UIFontMake(16) width:SCREEN_WIDTH-30]+[self.model.f_desc3 heightForFont:UIFontMake(16) width:SCREEN_WIDTH-30]+180:SCREEN_WIDTH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0?CGFLOAT_MIN:10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section != 0) {
        NSString *imgName = [NSString stringWithFormat:@"金融理财_%ld", indexPath.section];
        UIImageView *img = [[UIImageView alloc] initWithImage:UIImageMake(imgName)];
        [cell.contentView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }else {
        QMUILabel *describe2 = [[QMUILabel alloc] init];
        describe2.numberOfLines = 0;
        describe2.textAlignment = NSTextAlignmentCenter;
        describe2.text = self.model.f_desc2;
        describe2.font = UIFontMake(16);
        describe2.textColor = BASEBLACK;
        [cell.contentView addSubview:describe2];
        [describe2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView.mas_top).offset(15);
            make.left.equalTo(cell.contentView.mas_left).offset(15);
            make.right.equalTo(cell.contentView.mas_right).offset(-15);
        }];
        
        QMUILabel *projectName = [[QMUILabel alloc] init];
        projectName.textAlignment = NSTextAlignmentCenter;
        projectName.text = self.model.f_name;
        projectName.numberOfLines = 0;
        projectName.font = UIFontMake(24);
        projectName.textColor = BASEBLACK;
        [cell.contentView addSubview:projectName];
        [projectName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(describe2.mas_bottom).offset(10);
            make.left.right.equalTo(describe2);
        }];
        
        QMUILabel *describe3 = [[QMUILabel alloc] init];
        describe3.numberOfLines = 0;
        describe3.textAlignment = NSTextAlignmentCenter;
        describe3.textColor = BASEBLACK;
        describe3.text = self.model.f_desc3;
        describe3.font = UIFontMake(16);
        [cell.contentView addSubview:describe3];
        [describe3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(projectName.mas_bottom).offset(10);
            make.left.right.equalTo(projectName);
        }];
        
        QMUILabel *describe = [[QMUILabel alloc] init];
        describe.numberOfLines = 0;
        describe.textAlignment = NSTextAlignmentCenter;
        describe.textColor = UIColorGray;
        describe.font = UIFontMake(16);
        describe.text = self.model.f_desc;
        [cell.contentView addSubview:describe];
        [describe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(describe3);
            make.top.equalTo(describe3.mas_bottom).offset(10);
        }];
        
        QMUILabel *rate = [[QMUILabel alloc] init];
        rate.text = [NSString stringWithFormat:@"+%@%%", self.model.f_rate];
        rate.font = UIFontMake(22);
        rate.textColor = BASECOLOR;
        [cell.contentView addSubview:rate];
        [rate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.contentView.mas_centerX);
            make.top.equalTo(describe.mas_bottom).offset(15);
        }];
        
        QMUILabel *ratelab = [[QMUILabel alloc] init];
        ratelab.text = @"收益率";
        ratelab.font = UIFontMake(16);
        ratelab.textColor = BASEBLACK;
        [cell.contentView addSubview:ratelab];
        [ratelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.contentView.mas_centerX);
            make.top.equalTo(rate.mas_bottom).offset(10);
        }];
        
        QMUIButton *buy = [[QMUIButton alloc] init];
        buy.backgroundColor = BASECOLOR;
        [buy setTitle:@"立即购买" forState:UIControlStateNormal];
        [buy setTitle:@"购买结束" forState:UIControlStateDisabled];
        [buy setTitleColor:UIColorWhite forState:UIControlStateNormal>>UIControlStateDisabled];
        [cell.contentView addSubview:buy];
        [buy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.contentView.mas_centerX);
            make.top.equalTo(ratelab.mas_bottom).offset(10);
            make.size.mas_offset(CGSizeMake(200, 44));
        }];
        NSDate *data = [NSDate date];
        NSString *dateStr = [NSString stringWithFormat:@"%ld", (long)[data timeIntervalSince1970]];
        buy.enabled = (self.model.f_endtime.integerValue>dateStr.integerValue);
        buy.layer.cornerRadius = 10;
        buy.layer.masksToBounds = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

@end
