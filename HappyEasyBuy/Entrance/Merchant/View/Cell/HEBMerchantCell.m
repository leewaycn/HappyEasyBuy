//
//  HEBMerchantCell.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBMerchantCell.h"

@implementation HEBMerchantCell

- (void)setCellINFO {
    UIImageView *img = [[UIImageView alloc] init];
    selfClass(img);
    [self.contentView addSubview:img];
    
    QMUITextField *field = [[QMUITextField alloc] init];
    selfClass(field);
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.font = UIFontMake(16);
    [self.contentView addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(img.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
}

@end
