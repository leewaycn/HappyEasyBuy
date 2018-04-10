//
//  HEBCompanyDetailsVC.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2018/1/5.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBCompanyDetailsVC.h"
#import "HEBCycleScrollView.h"
#import "HEBSearchViewController.h"
#import "MTCategoryView.h"
@interface HEBCompanyDetailsVC ()<UIScrollViewDelegate>
/** 搜索btn */
@property(nonatomic, strong) QMUIButton *searchBtn;
/*轮播图 */
@property(nonatomic, weak) HEBCycleScrollView *cyView;
//分类视图
@property(nonatomic, weak) MTCategoryView *categoryView;
//scrollV
@property(nonatomic, weak) UIScrollView *scrollView;
@end

@implementation HEBCompanyDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorHex(#f1f1f1);
    
    [self loadSearchView];
    [self verbView];
    [self setupUI];
}




#pragma mark - 监听事件
// 分类视图的值改变事件
- (void)categoryViewValuechanged:(MTCategoryView *)sender {
    
    NSLog(@"%zd", sender.pageNumber);
    // 让scrollView滚动
    CGRect rect = CGRectMake(_scrollView.bounds.size.width * sender.pageNumber, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    // 让scrollView滚动,把rect区域的内容展示出来!
    [_scrollView scrollRectToVisible:rect animated:YES];
    
}

#pragma mark - 代理方法
// UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 0.如果不是用户滚动的,就不要设置偏移量了!
    if (!(scrollView.isDecelerating || scrollView.isDragging || scrollView.isTracking)) {
        return;
    }
    
    // 1.获取内容的偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //    NSLog(@"%f", offsetX);
    // 2.设置偏移距离给分类视图
    // 分类视图黄条的移动距离为 offsetX 的 3 分之 1
    _categoryView.offset_x = offsetX / 3;
    
}

#pragma mark 中间的分类按钮视图
-(void)setupUI{
    
    // 2.
    MTCategoryView *categoryV = [[MTCategoryView alloc] init];
    _categoryView = categoryV;
    categoryV.backgroundColor = [UIColor whiteColor];
    
    // 2.2 监听事件 值改变事件
    [categoryV addTarget:self action:@selector(categoryViewValuechanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:categoryV];
    
    [categoryV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.cyView.mas_bottom);
        make.left.right.equalTo(self.cyView);
        make.height.mas_equalTo(37);
    }];
    
    // 3.底部的滚动视图 UIScrollView!
    UIScrollView *scrollV = [self setupContentView
                             ];
    _scrollView = scrollV;
    scrollV.backgroundColor = [UIColor greenColor];
    [self.view addSubview:scrollV];
    [scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(categoryV.mas_bottom);
        make.left.right.equalTo(categoryV);
        make.bottom.equalTo(self.view).offset(-40);
    }];
 
    
    
    //    企业招聘View
    UIView *bottomView = [UIView new];
    //添加手势
    UITapGestureRecognizer * bottomViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewEvent:)];
    //将手势添加到需要相应的view中去
    [bottomView addGestureRecognizer:bottomViewGesture];
    //选择触发事件的方式（默认单机触发）
    [bottomViewGesture setNumberOfTapsRequired:1];
    
    
    [self.view addSubview: bottomView ];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_offset(40);
    }];
    
    UIImageView *bottomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    [bottomView addSubview:bottomImageView];
    [bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(10);
        make.centerY.equalTo(bottomView);
        make.width.height.mas_offset(20);
    }];
    
    UILabel *bottomLabel = [UILabel new];
    bottomLabel.text = @"企业招聘";
    //    bottomLabel.textColor = [UIColor orangeColor];
    bottomLabel.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomImageView.mas_right).offset(5);
        make.centerY.equalTo(bottomView);
    }];
}







#pragma mark 执行触发的方法

- (void)bottomViewEvent:(UITapGestureRecognizer *)bottomViewGesture{
    
    NSLog(@"点击企业View-公司是详情里的");
  
}




#pragma mark - 负责添加底部控制器视图的方法,并返回scrollView
- (UIScrollView *)setupContentView {
    
    UIScrollView *scrollV = [[UIScrollView alloc] init];
    scrollV.backgroundColor = [UIColor whiteColor];
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.pagingEnabled = YES;
    
    // 设置代理!
    scrollV.delegate = self;
    
    // MARK: - 添加控制器的视图
    NSArray<NSString *> *clsNameArr = @[@"HEBCompanyHomePageVC", @"HEBProductCenterVC", @"HEBContactUsVC"];
    
    // 定义可变数组,负责存放底部控制器视图的view!
    NSMutableArray<UIView *> *tempArrM = [NSMutableArray array];
    
    [clsNameArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 根据字符串动态的创建类 & 对象
        Class cls = NSClassFromString(obj);
        
        UIViewController *vc = [[cls alloc] init];
        NSAssert([vc isKindOfClass:[UIViewController class]], @"%@ 控制器类名 写的不对!", obj);
        
        // 添加控制器视图!
        [self cz_addChildController:vc intoView:scrollV];
        // 添加view
        [tempArrM addObject:vc.view];
    }];
    
    // 布局控制器的视图
    // 三个摆开,x!
    [tempArrM mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    // y size!
    [tempArrM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(scrollV);
        // 顶部距离 + 底部距离 + 自己的高度 才能够决定contentSize的高度!
        make.top.bottom.equalTo(scrollV);
        
    }];
    
    return scrollV;
}

#pragma mark//添加轮播图
- (void)verbView{
//    顶部1.轮播
    HEBCycleScrollView *cyView = [[HEBCycleScrollView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 140*SCREEN_WIDTH/375)];
    _cyView = cyView;
    [cyView startLocationCycleScrollViewType:@"7"];
    [self.view addSubview:cyView];
}


#pragma mark//添加导航栏搜索
- (void)loadSearchView {
    QMUIButton *searchBtn = [[QMUIButton alloc] initWithFrame:CGRectMake(50, (getNavigationHeight-28)/2-(IS_58INCH_SCREEN?22:10), SCREEN_WIDTH-90, 28)];
    selfClass(searchBtn);
    searchBtn.layer.cornerRadius = 12;
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.borderWidth = 1.f;
    searchBtn.layer.borderColor = UIColorMakeWithRGBA(210, 194, 194, 0.8).CGColor;
    searchBtn.backgroundColor = UIColorMakeWithRGBA(252, 249, 244, 0.8);
    [self.navigationController.navigationBar addSubview:searchBtn];
    
    UIImageView *searchimg = [[UIImageView alloc] initWithImage:UIImageMake(@"搜索")];
    [searchBtn addSubview:searchimg];
    [searchimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchBtn.mas_left).offset(15);
        make.top.equalTo(searchBtn.mas_top).offset(5);
        make.bottom.equalTo(searchBtn.mas_bottom).offset(-5);
        make.width.mas_offset(20);
    }];
    
    UIView *margin = [[UIView alloc] init];
    margin.backgroundColor = UIColorGray;
    [searchBtn addSubview:margin];
    [margin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchimg.mas_right).offset(9);
        make.top.bottom.equalTo(searchimg);
        make.width.mas_offset(1);
    }];
    
    QMUILabel *msg = [[QMUILabel alloc] init];
    msg.text = @"请输入商家或商品名称";
    msg.textColor = UIColorGray;
    msg.font = UIFontMake(14);
    [searchBtn addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchBtn.mas_centerY);
        make.left.equalTo(margin.mas_right).offset(8);
        make.right.equalTo(searchBtn.mas_right);
    }];
    
    __weak __typeof(self)weakSelf = self;
    [searchBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        HEBSearchViewController *search = [[HEBSearchViewController alloc] init];
        [weakSelf.navigationController pushViewController:search animated:YES];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.searchBtn setHidden:NO];
    if (IS_58INCH_SCREEN) {
        self.navigationController.navigationBar.barTintColor = BASECOLOR;
        self.navigationController.navigationBar.tintColor = UIColorWhite;
    }else {
        [self setNavigationBarTransparence];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
    [self.searchBtn setHidden:YES];
}


@end
