//
//  MTCategoryView.m
//  MT_waimai[007]
//
//  Created by HM on 16/8/5.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "MTCategoryView.h"

@interface MTCategoryView ()

/**
 *  点餐按钮  第一个按钮
 */
@property (weak, nonatomic) UIButton *firstBtn;

/**
 *  黄线
 */
@property (weak, nonatomic) UIView *lineView;

/**
 *  负责记录选中的按钮
 */
@property (weak, nonatomic) UIButton *selectBtn;

@end


@implementation MTCategoryView {

    /**
     *  保存3个按钮的集合
     */
    NSArray<UIButton *> *_btnsArr;

}

#pragma mark - 按钮的监听方法
- (void)categoryBtnClick:(UIButton *)sender {
    
    // 1.传出去的只需要按钮的索引,就可以了! indexOfObject 获取按钮的集合中的索引!
    _pageNumber = [_btnsArr indexOfObject:sender];

    // 2.发送事件
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    // 3.修改按钮的状态!
    _selectBtn.selected = NO;
    sender.selected = YES;
    _selectBtn = sender;
    
    // 4.让黄色线移动!
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(_firstBtn).offset(_pageNumber * _firstBtn.bounds.size.width);
        
    }];
    
    // 开启动画
    // 通过layoutIfNeed 让视图以动画的方式更新约束!
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}




#pragma mark - 重写set方法,进行偏移
- (void)setOffset_x:(CGFloat)offset_x {

    _offset_x = offset_x;
    
    // MARK: - 1.让黄条动!
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        // 让黄线的中心的x进行偏移
        make.centerX.equalTo(_firstBtn).offset(offset_x);
        
    }];
    
    // 布局
    [self layoutIfNeeded];
    
    // MARK: - 2.改变按钮状态
    CGFloat idxF = offset_x / _firstBtn.bounds.size.width;
//    NSLog(@"%@", @(idxF));
    
    NSInteger idx = offset_x / _firstBtn.bounds.size.width + 0.5;
    // 设置按钮的状态
    // 1.将之前保存的按钮设置为NO!
    _selectBtn.selected = NO;
    
    // 2.设置当前选中的按钮为YES!
    _btnsArr[idx].selected = YES;
    
    // 3.赋值
    _selectBtn = _btnsArr[idx];
}


- (void)setupUI {

    // MARK: - 1.添加3个按钮
    // 1.添加按钮
    NSArray<NSString *> *titlesArr = @[@"首页", @"产品中心", @"联系我们"];
    
    [titlesArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 1.创建按钮
        UIButton *btn = [UIButton cz_textButton:obj fontSize:14 normalColor:[UIColor cz_colorWithHex:0x555555] selectedColor:[UIColor orangeColor]];
        
        // 2.添加
        [self addSubview:btn];
        
        // 3.记录第一个按钮,用于设置黄线约束做参照!
        if (idx == 0) {
            _firstBtn = btn;
        }
        
        // 4.给分类视图的按钮添加监听事件
        [btn addTarget:self action:@selector(categoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    // 保存3个按钮
    _btnsArr = self.subviews;
    
    // 2.布局3个按钮
    [self.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [self.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.equalTo(self);
    }];
    
    // MARK: - 2.黄色的条子
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = [UIColor orangeColor];
    
    [self addSubview:lineV];
    
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(_firstBtn);
        make.bottom.equalTo(_firstBtn);
        make.centerX.equalTo(_firstBtn);
        make.height.mas_equalTo(4);
        
    }];
    
    // MARK: - 3.记录成员变量
    _lineView = lineV;
    
    
}

@end
