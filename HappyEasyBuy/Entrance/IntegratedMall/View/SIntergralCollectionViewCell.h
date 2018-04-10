//
//  SIntergralCollectionViewCell.h
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIntergralCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end
