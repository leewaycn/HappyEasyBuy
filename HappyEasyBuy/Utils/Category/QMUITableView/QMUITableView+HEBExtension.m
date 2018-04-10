//
//  QMUITableView+HEBExtension.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUITableView+HEBExtension.h"

@implementation QMUITableView (HEBExtension)

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.tableFooterView = [UIView new];
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UIColorHex(#f1f1f1);
        [self loadView];
    }
    return self;
}

- (void)loadView {
}

- (QMUITableViewCell *)cellForRow:(NSInteger)row inSection:(NSInteger)section {
    return [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

@end
