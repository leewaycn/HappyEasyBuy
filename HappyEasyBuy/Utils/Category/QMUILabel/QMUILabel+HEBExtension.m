//
//  QMUILabel+HEBExtension.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUILabel+HEBExtension.h"

@implementation QMUILabel (HEBExtension)

- (instancetype)initWithFrame:(CGRect)frame {
    self  = [super initWithFrame:frame];
    if (self) {
        self.text = @"--";
    }
    return self;
}

@end
