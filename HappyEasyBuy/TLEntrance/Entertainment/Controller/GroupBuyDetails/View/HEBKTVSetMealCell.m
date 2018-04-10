//
//  HEBKTVSetMealCell.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/8.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//
 //休闲Ktv团购-套餐详情cell
#import "HEBKTVSetMealCell.h"

@implementation HEBKTVSetMealCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        [self setupUI];
        
    }
    return self;
}

-(void)setupUI{
    
    UIImageView *iconImageV = [UIImageView new];
    iconImageV.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.width.height.mas_offset(30);
    
    }];
    
    UILabel *topLabel = [UILabel new];
    topLabel.text = @"topLabel";
    topLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageV.mas_right).offset(10);
        make.centerY.equalTo(iconImageV);
        
    }];
    
    UILabel *bottomLabel = [UILabel new];
    bottomLabel.text = @"bottomLabel";
    bottomLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageV.mas_right);
        make.bottom.equalTo(self.contentView).offset(-10);
        
    }];
    
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
