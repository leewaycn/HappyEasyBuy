//
//  HEBHotelListTableViewCell.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBEntertainmentistTabViewCell.h"
#import "HEBLevelView.h"
@interface HEBEntertainmentistTabViewCell ()
//头像
@property(weak, nonatomic)UIImageView *iconImagView;
//店铺名称
@property(weak, nonatomic)UILabel *nameLabel;
//星评视图
@property(weak, nonatomic)HEBLevelView *levelView;
//价格
@property(weak, nonatomic)UILabel *priceLabel;
//距离
@property(weak, nonatomic)UILabel *distanceLabel;


@end

@implementation HEBEntertainmentistTabViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        [self setupUI];
    }
    return self;
}

-(void)setLeisureListModel:(HEBLeisureListModel *)leisureListModel{
    _leisureListModel = leisureListModel;
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:leisureListModel.imgurl] options:YYWebImageOptionProgressive];
    self.nameLabel.text = leisureListModel.ha_name;
    self.priceLabel.text = [NSString stringWithFormat:@"%@元",leisureListModel.ha_pic] ;
    self.distanceLabel.text = leisureListModel.distance;
    self.levelView.fullStar = leisureListModel.score;
}


-(void)setupUI{
    
    
    //    休闲娱乐店铺头像
    UIImageView *iconImagView = [[UIImageView alloc]init];
    _iconImagView = iconImagView;
    //        iconImagView.contentMode = UIViewContentModeScaleAspectFit;
//    iconImagView.image = [UIImage imageNamed:@"微信支付"];
    [self.contentView addSubview:iconImagView];
    [iconImagView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_offset(60);
        make.width.mas_offset(60);
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
        
    }];
    
    //    店铺名称
    UILabel *nameLabel = [[UILabel alloc]init];
    _nameLabel = nameLabel;
    nameLabel.text = @"休闲娱乐Ktv测试";
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(5);
        make.left.equalTo(iconImagView.mas_right).offset(6);
        
    }];
    
    //    星评View
    HEBLevelView *levelView = [[HEBLevelView alloc]init];
    self.levelView = levelView;
    
    //        regionLabel.text = @"测试地址兰山区";
    //        regionLabel.font = [UIFont systemFontOfSize:12];
    //    LevelView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:levelView];
    [levelView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(nameLabel);
        make.top.equalTo(nameLabel.mas_bottom).offset(5);
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(70);
        make.height.mas_offset(14);
        
    }];
    
    //    价格
    UILabel *priceLabel = [[UILabel alloc]init];
    self.priceLabel = priceLabel;
    priceLabel.text = @"测试价格0.01元";
    priceLabel.font = [UIFont systemFontOfSize:12];
    priceLabel.textColor = [UIColor orangeColor];
    
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(levelView);
        
        make.top.equalTo(levelView.mas_bottom).offset(5);
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
    distanceLabel.textColor = [UIColor blackColor];
    _distanceLabel = distanceLabel;
    distanceLabel.text = @"测试12.8km";
    distanceLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview: distanceLabel];
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        
    }];
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
