//
//  backViewKtv.m
//  testModel
//
//  Created by 侯天龙 on 2017/12/31.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBGroupBuyDetailsBackView.h"
#import "HEBCycleScrollView.h"

@interface HEBGroupBuyDetailsBackView ()<UIScrollViewDelegate>
//底部金额按钮
@property(nonatomic, weak) UIButton *leftMoneyBtn;
//顶部店铺名称
@property(nonatomic, weak) UILabel * bigLab;
//套餐名称
@property(nonatomic, weak) UILabel * smallLab;
//店铺名称
@property(nonatomic, weak) UILabel * titleLab1;
//地址
@property(nonatomic, weak) UILabel * titleLab2;
//距离
@property(nonatomic, weak) UILabel * titleLab3;


@end
@implementation HEBGroupBuyDetailsBackView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self creatUI];
    }
    return self;
}

//赋值
-(void)setGroupBuyDetailsModel:(HEBGroupBuyDetailsModel *)groupBuyDetailsModel{

    self.bigLab.text = groupBuyDetailsModel.ha_name;
    self.smallLab.text = groupBuyDetailsModel.f_name;
    self.titleLab1.text = groupBuyDetailsModel.ha_name;
    self.titleLab2.text = groupBuyDetailsModel.ha_address;
    self.titleLab3.text = groupBuyDetailsModel.distance;
    
}

-(void)creatUI{
    
    self.backgroundColor = UIColorHex(#f1f1f1);
    UIScrollView * backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kUISCREENWIDTH, kUISCREENHEIGHT)];
    backScrollView.delegate = self;
    [self addSubview:backScrollView];
    //轮播图
    HEBCycleScrollView *cyView = [[HEBCycleScrollView alloc]initWithFrame:CGRectMake(0,-getNavigationHeight, SCREEN_WIDTH, 140)];
    //    _cyView = cyView;
    [cyView startLocationCycleScrollViewType:@"3"];
    [backScrollView addSubview:cyView];
    //下面文字 测试休闲店铺 套餐娱乐
    UIView * infoView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(cyView.frame), kUISCREENWIDTH, 60)];
    infoView.backgroundColor = [UIColor whiteColor];
    [backScrollView addSubview:infoView];
    //文字描述
    UILabel * bigLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kUISCREENWIDTH, 30)];
    bigLab.font = [UIFont systemFontOfSize:16];
    bigLab.textColor = [UIColor blackColor];
    bigLab.text = @"测试休闲店铺";
    _bigLab = bigLab;
    self.bigLab.text = self.groupBuyDetailsModel.ha_name;
    
    [infoView addSubview:bigLab];
    //文字描述2
    UILabel * smallLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, kUISCREENWIDTH, 30)];
    _smallLab = smallLab;
    smallLab.font = [UIFont systemFontOfSize:14];
    smallLab.textColor = [UIColor blackColor];
    smallLab.text = @"套餐娱乐";
    [infoView addSubview:smallLab];
    
    //商家信息
    UIView * businessInfo = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(infoView.frame)+10, kUISCREENWIDTH, 40)];
    businessInfo.backgroundColor = [UIColor whiteColor];
    [backScrollView addSubview:businessInfo];
    UILabel * businessLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kUISCREENWIDTH, 39)];
    businessLab.text = @"商家信息";
    businessLab.textColor = [UIColor grayColor];
    businessLab.font = [UIFont systemFontOfSize:16];
    [businessInfo addSubview:businessLab];
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 39, kUISCREENWIDTH, 1)];
    line.backgroundColor = [UIColor grayColor];
    [businessInfo addSubview:line];
    
    //商家详情
    UIView * detailView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(businessInfo.frame), kUISCREENHEIGHT, 90)];
    detailView.backgroundColor = [UIColor whiteColor];
    [backScrollView addSubview: detailView];
    //第1个lab
    UILabel * titleLab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kUISCREENWIDTH-50, 30)];
    _titleLab1 = titleLab1;
    titleLab1.font = [UIFont systemFontOfSize:16];
    titleLab1.textColor = [UIColor blackColor];
    titleLab1.text = @"套餐娱乐";
    [detailView addSubview:titleLab1];
    
    //第2个lab
    UILabel * titleLab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, kUISCREENWIDTH-50, 30)];
    _titleLab2 = titleLab2;
    titleLab2.font = [UIFont systemFontOfSize:14];
    titleLab2.textColor = [UIColor grayColor];
    titleLab2.text = @"山东省临沂市罗庄区";
    [detailView addSubview:titleLab2];
    
    //第3个lab
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 60, 20, 20)];
    icon.image = [UIImage imageNamed:@"定位"];
    [detailView addSubview:icon];
    
    UILabel * titleLab3 = [[UILabel alloc]initWithFrame:CGRectMake(45, 60, kUISCREENWIDTH-50, 30)];
    _titleLab3 = titleLab3;
    titleLab3.font = [UIFont systemFontOfSize:14];
    titleLab3.textColor = [UIColor grayColor];
    titleLab3.text = @"7.2km";
    [detailView addSubview:titleLab3];
    
    //后面打电话的按钮屏幕的宽度为50
    UIView * telView = [[UIView alloc]initWithFrame:CGRectMake(kUISCREENWIDTH-50, 0, 50, 90)];
    [detailView addSubview:telView];
    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 1, 70)];
    line1.backgroundColor = [UIColor grayColor];
    [telView addSubview:line1];
    UIButton * telBtn = [[UIButton alloc]initWithFrame:CGRectMake(1, 0, 50, 90)];
    [telBtn setImage:[UIImage imageNamed:@"dainhua@2x"] forState:UIControlStateNormal];
    [telView addSubview:telBtn];
    [telBtn addTarget:self action:@selector(telBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //设置背景视图的滚动高度
    [backScrollView setContentSize:CGSizeMake(0, kUISCREENHEIGHT+CGRectGetMaxY(detailView.frame))];
    backScrollView.showsHorizontalScrollIndicator = NO;

    //分段选择器
    self.drugCategorySegmentedControl.frame = CGRectMake(0, CGRectGetMaxY(detailView.frame)+10, kUISCREENWIDTH, 50);
    [backScrollView addSubview:self.drugCategorySegmentedControl];
    //分段选择器底部视图
    self.tableScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.drugCategorySegmentedControl.frame), kUISCREENWIDTH, kUISCREENHEIGHT-100)];
    self.tableScroll.pagingEnabled = YES;
    self.tableScroll.delegate = self;
    [self.tableScroll setContentSize:CGSizeMake(kUISCREENWIDTH*3, 0)];
    self.tableScroll.backgroundColor = [UIColor whiteColor];
    [backScrollView addSubview:self.tableScroll];
 
    
}




#pragma mark - 打电话功能
-(void)telBtnClick{
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"186xxxx6979"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}
#pragma mark - scrollView 滚动的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = scrollView.contentOffset.x / pageWidth;
    
    if (scrollView == self.tableScroll) {
        
        self.drugCategorySegmentedControl.selectedSegmentIndex = page;
        if (self.optionBlock) {
            
            self.optionBlock(page);
        }
    }
}

#pragma mark - 点击分段选择器的方法
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSInteger  page =  segmentedControl.selectedSegmentIndex;

    [self.tableScroll setContentOffset:CGPointMake(kUISCREENWIDTH * page,0) animated:YES];

    if (self.optionBlock) {

        self.optionBlock(page);
    }

}
- (HMSegmentedControl *)drugCategorySegmentedControl {
    if (_drugCategorySegmentedControl == nil) {
        HMSegmentedControl *drugCategorySegmentedControl = [[HMSegmentedControl alloc] init];
        //分段选择器的标题
        drugCategorySegmentedControl.sectionTitles = @[@"套餐",@"网友点评",@"购买须知"];
        //分段选择器默认被选中的索引
        drugCategorySegmentedControl.selectedSegmentIndex = 0;
        drugCategorySegmentedControl.frame = CGRectMake(0, 0, kUISCREENWIDTH, 50);

        drugCategorySegmentedControl.selectedSegmentIndex = 0;

        //分段选择器的背景颜色
        drugCategorySegmentedControl.backgroundColor =  [UIColor whiteColor];

        //分段选择器中标题文字的颜色
        [drugCategorySegmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {

            NSAttributedString *attString = nil;

            attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:14]}];
            if (selected) {
                attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor orangeColor], NSFontAttributeName : [UIFont systemFontOfSize:14]}];
            }
            return attString;
        }];

        //小滑块的颜色
        drugCategorySegmentedControl.selectionIndicatorColor = [UIColor orangeColor];

        //设置滑块的透明度，1.0表示完全不透明
        drugCategorySegmentedControl.selectionIndicatorBoxOpacity = 1.0;

        //小滑块的样式
        drugCategorySegmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        drugCategorySegmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, 0, 3, 0);

        //小滑块的位置
        drugCategorySegmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        [drugCategorySegmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
        _drugCategorySegmentedControl = drugCategorySegmentedControl;
    }
    return _drugCategorySegmentedControl;
}


@end
