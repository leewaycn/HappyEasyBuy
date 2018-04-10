//
//  QMUITableView+HEBExtension.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface QMUITableView (HEBExtension)

/**
 通过位置返回cell

 @param row row
 @param section section
 @return cell
 */
- (QMUITableViewCell *)cellForRow:(NSInteger)row inSection:(NSInteger)section;

@end
