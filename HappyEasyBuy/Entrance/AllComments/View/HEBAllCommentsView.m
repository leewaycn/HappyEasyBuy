//
//  HEBAllCommentsView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBAllCommentsView.h"
#import <KSPhotoBrowser.h>
#import "HEBPackageDetailsAppraiseView.h"

@interface HEBAllCommentsView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBAllCommentsView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellModelArrM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HEBPackageDetailsAppraiseModel *model = self.cellModelArrM[indexPath.row];
    return model.content.heightWith14_90+70+(model.icon.count?(SCREEN_WIDTH/6):0)+(model.status?(60+model.reply_cont.heightWith14_90):0);
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
    cell.dividingLine = YES;
    __weak __typeof(self)weakSelf = self;
    HEBPackageDetailsAppraiseModel *model = self.cellModelArrM[indexPath.row];
    HEBPackageDetailsAppraiseView *appraiseView = [[HEBPackageDetailsAppraiseView alloc] init];
    [appraiseView.header yy_setImageWithURL:[NSURL URLWithString:model.headimg] options:YYWebImageOptionProgressive];
    appraiseView.userName.text = model.name;
    appraiseView.time.text = model.time;
    [appraiseView.start displayRating:model.score];
    appraiseView.msg.text = model.content;
    appraiseView.respond.hidden = !model.status;
    appraiseView.bg.hidden = !model.status;
    if (model.status) {
        appraiseView.shopMsg.text = model.reply_cont;
        [appraiseView.shopMsg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo((model.icon.count?appraiseView.imgArrM.lastObject:appraiseView.msg).mas_bottom).offset(35);
            make.left.equalTo(appraiseView.header.mas_centerX).offset(5);
            make.right.equalTo(appraiseView.mas_right).offset(-15);
        }];
    }
    if (model.icon.count) {
        @weakify(appraiseView);
        NSMutableArray<KSPhotoItem *> *items = [NSMutableArray array];
        [model.icon enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            KSPhotoItem *item = [KSPhotoItem itemWithSourceView:weak_appraiseView.imgArrM[idx] imageUrl:[NSURL URLWithString:obj]];
            [items addObject:item];
            [weak_appraiseView.imgArrM[idx] yy_setImageWithURL:[NSURL URLWithString:obj] options:YYWebImageOptionProgressive];
            [weak_appraiseView.imgArrM[idx] setUserInteractionEnabled:YES];
            [weak_appraiseView.imgArrM[idx] addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:idx];
                [browser showFromViewController:weakSelf.viewController];
            }]];
        }];
    }else {
        [appraiseView.imgArrM enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [appraiseView.imgArrM removeAllObjects];
    }
    [cell.contentView addSubview:appraiseView];
    [appraiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
}

- (NSMutableArray<HEBPackageDetailsAppraiseModel *> *)cellModelArrM {
    if (!_cellModelArrM) {
        _cellModelArrM = [NSMutableArray array];
    }
    return _cellModelArrM;
}

@end
