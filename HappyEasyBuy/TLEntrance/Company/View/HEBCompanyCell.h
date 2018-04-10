//
//  HEBCompanyCell.h
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/4.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HEBCompanyModel.h"
@interface HEBCompanyCell : UITableViewCell

@property(nonatomic, strong) HEBCompanyModel *companyModel;
@property(nonatomic, weak)UIButton *detailsButton;

@end
