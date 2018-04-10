//
//  HEBroofView.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBMyCenterHeaderView.h"

@interface HEBMyCenterHeaderView ()

@end

@implementation HEBMyCenterHeaderView

- (void)loadView {
    self.backgroundColor = BASECOLOR;
    UIButton *header = [[UIButton alloc] init];
    selfClass(header);
    header.layer.cornerRadius = 40.0;
    header.clipsToBounds = TRUE;
    [self addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(1);
        make.centerX.equalTo(self.mas_centerX);
        make.width.height.mas_equalTo(80);
    }];
    UIImageView *img = [[UIImageView alloc] init];
    selfClass(img);
    [header addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(header);
    }];
    
    /** 用户名称 */
    QMUILabel *nickName = [[QMUILabel alloc] init];
    nickName.textColor = UIColorWhite;
    selfClass(nickName);
    nickName.font = UIFontMake(14);
    [self addSubview:nickName];
    [nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header.mas_bottom).offset(2);
        make.centerX.equalTo(self);
    }];
    if (getUser_id && @"header".getUserDefaultsINFO && @"nickName".getUserDefaultsINFO) {
        [img yy_setImageWithURL:[NSURL URLWithString:@"header".getUserDefaultsINFO] options:YYWebImageOptionProgressive];
        nickName.text = @"nickName".getUserDefaultsINFO;
    }else {
        img.image = UIImageMake(@"默认头像");
        nickName.text = @"请登录";
    }
}

@end
