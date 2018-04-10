//
//  HEBCompanyRightCell.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/6.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//
#define FontSize 14

#import "HEBCompanyRightCell.h"

@implementation HEBCompanyRightCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
}


-(void)setupUI{
//    logo
    UIImageView *iconImageV = [UIImageView new];
    iconImageV.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview: iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(40);
    }];
//    产品名称
    UILabel *nameTitlLabel = [UILabel new];
    nameTitlLabel.text = @"产品名称:";
    nameTitlLabel.font = [UIFont systemFontOfSize:FontSize];
    [self.contentView addSubview:nameTitlLabel];
    [nameTitlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageV.mas_right).offset(10);
        make.top.equalTo(iconImageV.mas_top);
    }];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = @"网站定制";
    nameLabel.font = [UIFont systemFontOfSize:FontSize];
    [self.contentView addSubview: nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameTitlLabel.mas_right);
        make.centerY.equalTo(nameTitlLabel);
        
    }];
//    规格
    UILabel *specTitlLabel = [UILabel new];
    specTitlLabel.text = @"规格：";
    specTitlLabel.font = [UIFont systemFontOfSize:FontSize];
    [self.contentView addSubview:specTitlLabel];
    [specTitlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameTitlLabel);
        make.bottom.equalTo(iconImageV);
        
    }];
    
    UILabel *specLabel = [UILabel new];
    specLabel.text = @"98k";
    specLabel.font =[UIFont systemFontOfSize:FontSize];
    [self.contentView addSubview:specLabel];
    [specLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.centerY.equalTo(specTitlLabel);
    }];
    
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    NSLog(@"点击产品cell");
}

@end
