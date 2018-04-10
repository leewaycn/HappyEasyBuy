
//
//  HEBContactUsCell.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/5.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//
#define FontSize 14

#import "HEBContactUsCell.h"
#import "CZAdditions.h"

@interface HEBContactUsCell()

@property(nonatomic, weak) UILabel *hotlineTitl;

@property(nonatomic, weak)UILabel *hotline;

@end

@implementation HEBContactUsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{

    UIView *hotlineView = [UIView new];
    hotlineView.backgroundColor = [UIColor orangeColor];
    hotlineView.layer.cornerRadius = 8;
    hotlineView.layer.masksToBounds = YES;
    [self.contentView addSubview:hotlineView];
    [hotlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(10);
    }];
    
//    UIRectCornerAllCorners
//
//    UIImageView *hotlineImageV = [UIImageView new];
//    hotlineImageV.image = [UIImage imageNamed:@""];
//
    UILabel *hotlineTitl = [UILabel new];
    _hotlineTitl = hotlineTitl;
    hotlineTitl.text = @"咨询热线";
    [self.contentView addSubview:hotlineTitl];
    [hotlineTitl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hotlineView.mas_right).offset(5);
        make.centerY.equalTo(hotlineView);
        
    }];
    
    UILabel *hotline = [UILabel new];
    hotline.text = @"123";
    [self.contentView addSubview:hotline];
    [hotline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hotlineTitl.mas_right).offset(30);
        make.centerY.equalTo(hotlineTitl);
        
    }];
 
}

-(void)setUsModel:(HEBContaactUsModel *)usModel{
    
    
}


//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
