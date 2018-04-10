//
//  SIntergralCollectionViewCell.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "SIntergralCollectionViewCell.h"

@interface SIntergralCollectionViewCell()

@end

@implementation SIntergralCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.addBtn.layer.cornerRadius = 5;
    self.addBtn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor lightGrayColor]);
    self.addBtn.layer.borderWidth = 1;
    
}

@end
