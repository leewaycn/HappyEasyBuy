//
//  HEBLevelView.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBLevelView.h"

@implementation HEBLevelView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        /* 添加子控件的代码*/
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    //    NSLog(@"xxxx");
    //    self.backgroundColor = [UIColor redColor];
    CGFloat width = 14;
    CGFloat height = width;
    
    for (NSInteger i = 0; i<5; i++) {
        UIImageView *starImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"星评_未选中"]];
        
        starImage.frame = CGRectMake(i * width, 0, width, height);
        
        [self addSubview:starImage];
    }
}
- (void)setLevel:(CGFloat)level{
    _level = level;
    
    //拿到数据以后，先把前一个缓存的数据全部清空
    for (UIImageView *starImage in self.subviews) {
        starImage.image = [UIImage imageNamed:@"星评_未选中"];
    }
    
    //cell把星级传递给了levelView，拿到数据以后，要设置到底有几个星星。
    //level = 4    fullStar = 4;
    //level = 2.5  fullStar = 2;
//    NSInteger fullStar = (NSInteger)level;
    
    for (NSInteger i = 0; i<self.fullStar; i++) {
        UIImageView *starImage = self.subviews[i];
        starImage.image = [UIImage imageNamed:@"星评_选中"];
    }
    
//    //说明有半颗星星
//    if(level - fullStar > 0){
//        //拿到满星的下一个子控件
//        UIImageView *halfStar = self.subviews[fullStar];
//        halfStar.image = [UIImage imageNamed:@"half_star"];
//    }
}

@end
