//
//  HEBKTVNoticeCell.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/8.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//
//**休闲KTV套餐详情-购买须知cell */
#import "HEBKTVNoticeCell.h"

@implementation HEBKTVNoticeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    UILabel *titlLabel = [UILabel new];
    _titlLabel = titlLabel;
    titlLabel.text = @"有效期";
    titlLabel.font = [UIFont systemFontOfSize:14];
    titlLabel.textColor = [UIColor orangeColor];
    [self.contentView addSubview:titlLabel];
    [titlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    UILabel *contentLabel = [UILabel new];
    _contentLabel = contentLabel;
    contentLabel.text = @"显示内容";
    contentLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titlLabel).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
