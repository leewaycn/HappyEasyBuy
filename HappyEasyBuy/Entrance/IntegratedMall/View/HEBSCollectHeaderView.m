//
//  HEBSCollectHeaderView.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBSCollectHeaderView.h"

@interface HEBSCollectHeaderView()



@end
@implementation HEBSCollectHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.searchTF.leftViewMode = UITextFieldViewModeAlways;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 36, 35)];
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(35, 7, 1, 20)];
    blankView.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:blankView];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(7.5, 7.5, 20, 20)];
    imgV.image = [UIImage imageNamed:@"sousuo"];
    [view addSubview:imgV];
    self.searchTF.leftView = view;
}

@end
