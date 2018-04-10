//
//  UITableView+HEBExtension.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/27.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "UITableView+HEBExtension.h"

@implementation UITableView (HEBExtension)

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
