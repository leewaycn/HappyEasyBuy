
//
//  HEBsorteTableViewCell.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//
/** 排序视图cell*/

#import "HEBsorteTableViewCell.h"
@implementation HEBsorteTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    UILabel *titlLabel = [UILabel new];
    titlLabel.font = [UIFont systemFontOfSize:14];
//    titlLabel.text = @"智能排序";
    [self.contentView addSubview:titlLabel];
    [titlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.centerY.equalTo(self.contentView);
        
    }];
    _titlLabel = titlLabel;
    
    UIImageView *imgView = [[UIImageView alloc]init];
//    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.image = [UIImage imageNamed:@"选中"];
    imgView.hidden = YES;
    [self.contentView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.size.mas_offset(20);
    }];
    _imgView = imgView;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.imgView.hidden = !selected;
    
}


@end
