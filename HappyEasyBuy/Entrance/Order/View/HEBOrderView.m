//
//  HEBOrderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderView.h"
#import "HEBOrderListViewController.h"

@interface HEBOrderView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) NSArray<NSString *> *cellModelArr;

@end

@implementation HEBOrderView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellModelArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return  [UIView new];
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIImageView *img = [[UIImageView alloc] initWithImage:UIImageMake(self.cellModelArr[indexPath.section])];
    [cell.contentView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.left.equalTo(cell.contentView.mas_left).offset(15);
    }];
    QMUILabel *msg = [[QMUILabel alloc] init];
    msg.text = self.cellModelArr[indexPath.section];
    msg.textColor = BASEBLACK;
    msg.font = UIFontMake(14);
    [cell.contentView addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.left.equalTo(img.mas_right).offset(15);
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    if (getUser_id) {
        HEBOrderListViewController *orderlist = [[HEBOrderListViewController alloc] init];
        orderlist.type = [NSString stringWithFormat:@"%ld", indexPath.section+1];
        orderlist.title = self.cellModelArr[indexPath.section];
        [self.viewController.navigationController pushViewController:orderlist animated:YES];
    }else{
        ISAlertNotLoginMessage;
    }
}

- (NSArray<NSString *> *)cellModelArr {
    if (!_cellModelArr) {
        _cellModelArr = @[@"美食团购订单",
                          /*@"电影演出订单",
                          @"休闲／KTV订单",
                          @"酒店／住宿订单",*/
                          @"美食外卖订单",
                          @"积分商城订单"];
    }
    return _cellModelArr;
}

@end
