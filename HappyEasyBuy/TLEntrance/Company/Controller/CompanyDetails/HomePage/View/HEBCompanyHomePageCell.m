//
//  HEBCompanyHomePageCell.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/5.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBCompanyHomePageCell.h"

@implementation HEBCompanyHomePageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    UILabel * introduceTitl = [UILabel new];
    introduceTitl.text = @"标题";
    introduceTitl.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview: introduceTitl ];
    [introduceTitl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
    }];
    
    UILabel *introduce = [UILabel new];
    introduce.text = @"内容";
//    自动换行
    introduce.numberOfLines = 0;
    introduce.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:introduce];
    [introduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(introduceTitl);
        make.top.equalTo(introduceTitl.mas_bottom).offset(15);
        
    }];
    
}







//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
