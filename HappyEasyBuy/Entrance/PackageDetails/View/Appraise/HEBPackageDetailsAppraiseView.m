//
//  HEBPackageDetailsAppraiseView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBPackageDetailsAppraiseView.h"

@implementation HEBPackageDetailsAppraiseView

- (void)loadView {
    UIImageView *header = [[UIImageView alloc] init];
    selfClass(header);
    [self addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(15);
        make.size.mas_offset(50);
    }];
    header.layer.cornerRadius = 25;
    header.layer.masksToBounds = YES;
    
    QMUILabel *time = [[QMUILabel alloc] init];
    selfClass(time);
    time.textColor = UIColorGray;
    time.font = UIFontMake(14);
    [self addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header.mas_top);
        make.right.equalTo(self.mas_right).offset(-5);
        make.width.mas_offset(150);
    }];
    
    QMUILabel *userName = [[QMUILabel alloc] init];
    selfClass(userName);
    userName.font = UIFontMake(16);
    [self addSubview:userName];
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header.mas_top);
        make.right.equalTo(time.mas_left);
        make.left.equalTo(header.mas_right).offset(10);
    }];
    
    RatingBar *start = [[RatingBar alloc] init];
    selfClass(start);
    start.isIndicator = YES;
    [start setImageDeselected:@"星评_未选中" halfSelected:nil fullSelected:@"星评_选中" andDelegate:nil];
    [self addSubview:start];
    [start mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userName.mas_left);
        make.top.equalTo(userName.mas_bottom).offset(5);
        make.size.mas_offset(CGSizeMake(70, 15));
    }];
    
    QMUILabel *msg = [[QMUILabel alloc] init];
    selfClass(msg);
    msg.font = UIFontMake(14);
    [self addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(start.mas_bottom).offset(5);
        make.left.equalTo(userName.mas_left);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    for (int i = 0; i < 4; i ++) {
        UIImageView *sender = [[UIImageView alloc] init];
        [self addSubview:sender];
        [sender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(msg.mas_bottom).offset(5);
            make.left.equalTo(userName.mas_left).offset(i*(SCREEN_WIDTH/6+10));
            make.size.mas_offset(SCREEN_WIDTH/6);
        }];
        [self.imgArrM addObject:sender];
    }
    
    QMUILabel *shopMsg = [[QMUILabel alloc] init];
    shopMsg.numberOfLines = 0;
    selfClass(shopMsg);
    shopMsg.font = UIFontMake(14);
    shopMsg.textColor = BASEBLACK;
    [self addSubview:shopMsg];
    
    UIView *bg = [[UIView alloc] init];
    selfClass(bg);
    bg.hidden = YES;
    bg.backgroundColor = UIColorHex(#f1f1f1);
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopMsg.mas_top).offset(-25);
        make.bottom.equalTo(shopMsg.mas_bottom).offset(20);
        make.left.right.equalTo(self);
    }];
    [self sendSubviewToBack:bg];
    
    YYTextSimpleEmoticonParser *parser = [[YYTextSimpleEmoticonParser alloc] init];
    parser.emoticonMapper = @{@"respond":UIImageMake(@"商家回应")};
    YYLabel *respond = [[YYLabel alloc] init];
    selfClass(respond);
    respond.text = [NSString stringWithFormat:@"respond 商家回应:"];
    respond.font = UIFontMake(14);
    respond.textColor = BASECOLOR;
    respond.textParser = parser;
    [self addSubview:respond];
    [respond mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg.mas_top).offset(5);
        make.left.equalTo(header.mas_centerX);
    }];
    
}

- (NSMutableArray<UIImageView *> *)imgArrM {
    if (!_imgArrM) {
        _imgArrM = [NSMutableArray array];
    }
    return _imgArrM;
}

@end
