//
//  HEBPicCell.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBPicCell.h"

@implementation HEBPicCell

- (void)setCellINFO {
    UIImageView *icon = [[UIImageView alloc] init];
    selfClass(icon);
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

@end
