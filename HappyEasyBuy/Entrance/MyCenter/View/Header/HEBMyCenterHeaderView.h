//
//  HEBroofView.h
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"

@interface HEBMyCenterHeaderView : QMUIView

/** 用户头像按钮 */
@property(nonatomic, strong) UIButton *header;

/** 用户头像 */
@property(nonatomic, strong) UIImageView *img;

/** 用户昵称 */
@property(nonatomic, strong) QMUILabel *nickName;

@end
