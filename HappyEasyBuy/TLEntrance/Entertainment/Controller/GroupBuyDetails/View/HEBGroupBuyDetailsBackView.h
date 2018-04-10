//
//  backViewKtv.h
//  testModel
//
//  Created by 侯天龙 on 2017/12/31.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "HEBGroupBuyDetailsModel.h"
typedef void(^optionBlock)(int page);

#define kUISCREENWIDTH  [UIScreen mainScreen].bounds.size.width     //屏幕宽度
#define kUISCREENHEIGHT [UIScreen mainScreen].bounds.size.height    //屏幕高度
@interface HEBGroupBuyDetailsBackView : UIView
@property (nonatomic, strong) HMSegmentedControl *drugCategorySegmentedControl;//分段选择器
@property (nonatomic,copy) optionBlock  optionBlock;//分段选择器的点击block
@property (nonatomic,strong) UIScrollView *  tableScroll;//底部视图 套餐 网友点评 购买须知

//接受控制器传过来的模型数据
@property(nonatomic, strong)HEBGroupBuyDetailsModel *groupBuyDetailsModel;


-(void)creatUI;
@end
