//
//  HEBHotelTableViewCell.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBHotelTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface HEBHotelTableViewCell()
//**头像  *//
@property(strong, nonatomic)UIImageView *iconImagView;
//酒店名称
@property(strong,nonatomic)UILabel *nameLabel;
//地区
@property(strong,nonatomic)UILabel *regionLabel;
//价格
@property(strong,nonatomic)UILabel *priceLabel;
//距离
@property(strong,nonatomic)UILabel *distanceLabel;


@end

@implementation HEBHotelTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        [self setupUI];
    }
    return self;
}

//

-(void)setHotSellModel:(HEBHoteListlModel *)hotSellModel {
    
     [self.iconImagView yy_setImageWithURL:[NSURL URLWithString:hotSellModel.h_pic] options:YYWebImageOptionProgressive];
//    NSLog(@"wwwwww%@----",hotSellModel.h_pic);
    self.nameLabel.text = hotSellModel.h_name;
    self.regionLabel.text = hotSellModel.h_address;
    self.priceLabel.text = [NSString stringWithFormat:@"%@元",hotSellModel.h_price];
    self.distanceLabel.text = hotSellModel.distance;
}


-(void)setupUI{
    
   
//    酒店头像
    UIImageView *iconImagView = [[UIImageView alloc]init];
    _iconImagView = iconImagView;
    iconImagView.contentMode = UIViewContentModeScaleAspectFit;
    iconImagView.image = [UIImage imageNamed:@"乐享币支付"];
    [self.contentView addSubview:iconImagView];
    [iconImagView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.width.mas_offset(50);
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
        
    }];
    
//    店铺名称
    UILabel *nameLabel = [[UILabel alloc]init];
    _nameLabel = nameLabel;
    nameLabel.text = @"测试酒店";
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView).offset(5);
        make.left.equalTo(iconImagView.mas_right).offset(6);
        
    }];
    
//    店铺地址
    UILabel *regionLabel = [[UILabel alloc]init];
    self.regionLabel = regionLabel;
    regionLabel.text = @"测试地址兰山区+";
    regionLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:regionLabel];
    [regionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(nameLabel);
        make.top.equalTo(nameLabel.mas_bottom).offset(5);
        make.centerY.equalTo(self.contentView);
    
    }];
    
//    价格
    UILabel *priceLabel = [[UILabel alloc]init];
    _priceLabel = priceLabel;
    priceLabel.text = @"测试价格1元";
    priceLabel.font = [UIFont systemFontOfSize:12];
    priceLabel.textColor = [UIColor orangeColor];
    
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(regionLabel);
        
        make.top.equalTo(regionLabel.mas_bottom).offset(5);
//        make.width.mas_equalTo(100);
        
    }];
//    单位：元
    UILabel *yuanLabel = [[UILabel alloc]init];
    yuanLabel.text = @"起";
    yuanLabel.font = [UIFont systemFontOfSize:12];
    
    [self.contentView addSubview: yuanLabel];
    [yuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(priceLabel.mas_right);
        make.centerY.equalTo(priceLabel);
        
    }];
    
    //距离
    UILabel *distanceLabel = [[UILabel alloc]init];
    _distanceLabel = distanceLabel;
    distanceLabel.text = @"测试12.8km";
    distanceLabel.font = [UIFont systemFontOfSize:12];

    [self.contentView addSubview: distanceLabel];
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-5);

    }];

}




@end
