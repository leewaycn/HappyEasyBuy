//
//  HEBGetCouponsView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBGetCouponsView.h"
#import "HEBGetCouponsCell.h"

@interface HEBGetCouponsView ()<QMUITableViewDelegate, QMUITableViewDataSource, UIGestureRecognizerDelegate>

@property(nonatomic, strong) UIView *nav;

@property(nonatomic, strong) QMUITableView *tableView;

@end

@implementation HEBGetCouponsView

- (void)loadView {
    self.backgroundColor = UIColorMakeWithRGBA(1, 1, 1, 0.5);
    
    [self loadNav];
    
    [self loadTableView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelf)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
}

- (void)loadNav {
    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 170, SCREEN_WIDTH, 44)];
    selfClass(nav);
    nav.backgroundColor = UIColorWhite;
    [self addSubview:nav];
    QMUILabel *title = [[QMUILabel alloc] init];
    title.text = @"优惠券";
    title.font = UIFontMake(18);
    [nav addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(nav);
    }];
    
    QMUIButton *close = [[QMUIButton alloc] init];
    [close setBackgroundImage:UIImageMake(@"关闭") forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closeDidClick) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:close];
    [close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nav.mas_centerY);
        make.right.equalTo(nav.mas_right).offset(-15);
        make.size.mas_offset(close.currentBackgroundImage.size);
    }];
}

- (void)loadTableView {
    QMUITableView *tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.tag = 100;
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    selfClass(tableView);
    tableView.dataSource = self;
    tableView.delegate = self;
    [self addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nav.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellModelArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof(self)weakSelf = self;
    static NSString *identifier = @"cell";
    HEBGetCouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HEBGetCouponsCell alloc] initForTableView:tableView withReuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    [cell setCell];
    HEBGetCouponsModel *model = self.cellModelArr[indexPath.section];
    cell.reduce.text = [NSString stringWithFormat:@"¥ %@", model.money];
    cell.conditions.text = [NSString stringWithFormat:@"满 %@ 使用", model.usemoney];
    cell.aging.text = [NSString stringWithFormat:@"有效期 %@-%@", model.stime.timeStampYYYYMMDDPoint, model.etime.timeStampYYYYMMDDPoint];
    [cell.pickUp addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if (weakSelf.getDidSelectCoupons) {
            weakSelf.getDidSelectCoupons(model.objid);
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (void)closeDidClick {
    [UIView animateWithDuration:1.25 animations:^{
        self.top = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeAllSubviews];
        [self removeFromSuperview];
    }];
}

- (NSArray<HEBGetCouponsModel *> *)cellModelArr {
    if (!_cellModelArr) {
        _cellModelArr = [NSArray array];
    }
    return _cellModelArr;
}

- (void)removeSelf {
    [self closeDidClick];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return !(touch.view.tag == 100);
}

@end
