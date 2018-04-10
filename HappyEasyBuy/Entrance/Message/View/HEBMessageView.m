//
//  HEBMessageView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/8.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBMessageView.h"
#import "HEBMessageCell.h"

@interface HEBMessageView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBMessageView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageModelArrM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HEBMessageModel *model = self.messageModelArrM[indexPath.row];
    return [model.title heightForFont:UIFontMake(16) width:SCREEN_WIDTH-30]+model.content.heightWith14_30+40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    HEBMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HEBMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    [cell setCellINFO];
    cell.dividingLine = YES;
    HEBMessageModel *model = self.messageModelArrM[indexPath.row];
    cell.title.text = model.title;
    cell.content.text = model.content;
    cell.time.text = model.ctime;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (NSMutableArray *)messageModelArrM {
    if (!_messageModelArrM) {
        _messageModelArrM = [NSMutableArray array];
    }
    return _messageModelArrM;
}

@end
