//
//  HEBCompanyCell.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/4.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBCompanyCell.h"
@interface HEBCompanyCell()

@property(nonatomic, weak)UIImageView *iconImageView;
@property(nonatomic, weak)UILabel *nameLabel;
@property(nonatomic, weak)UILabel *locationLabel;

@end


@implementation HEBCompanyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        [self setupUI];
    }
    return self;
}

//赋值cell子空控件
-(void)setCompanyModel:(HEBCompanyModel *)companyModel{
    
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString: companyModel.logo] options:YYWebImageOptionProgressive];
    self.nameLabel.text = companyModel.name;
    self.locationLabel.text = companyModel.address;
    
}


-(void)setupUI{
    UIImageView *iconImageView = [[UIImageView alloc]init];
    _iconImageView = iconImageView;
    iconImageView.layer.cornerRadius = 6;
    iconImageView.layer.masksToBounds = YES;
    
    [self.contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(60);
    }];
//    公司名称
    UILabel *nameLabel = [UILabel new];
    self.nameLabel = nameLabel;
    nameLabel.text = @"公司名称";
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).offset(8);
        make.top.equalTo(iconImageView).offset(5);
        
    }];
//  公司地址
    UILabel *locationLabel = [UILabel new];
    self.locationLabel = locationLabel;
    locationLabel.text = @"山东临沂龙湖软件园";
    locationLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:locationLabel];
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.bottom.equalTo(iconImageView).offset(-5);

    }];
//    公司详情按钮
    UIButton *detailsButton = [UIButton new];
    self.detailsButton = detailsButton;
    [detailsButton setImage:[UIImage imageNamed:@"gongsixiangqing"] forState:UIControlStateNormal];
    [self.contentView addSubview:detailsButton];
    [detailsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
        
    }];
    
}





//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    NSLog(@"只要998");
//
//}

@end
