//
//  UICollectionView+HEBExtension.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/11.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "UICollectionView+HEBExtension.h"

@implementation UICollectionView (HEBExtension)

- (UIImage *)cd_noDataViewImage {
    self.mj_footer.hidden = YES;
    return UIImageMake(@"无数据");
}

- (void)cd_hasData {
    /** 不知道什么原因，写上这句话就会导致pickview无法正常显示，中间视图会被隐藏掉 */
    //    self.backgroundColor = UIColorHex(#f1f1f1);
    self.mj_footer.hidden = NO;
}

@end
