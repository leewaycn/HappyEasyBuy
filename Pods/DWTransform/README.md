[![CocoaPods](http://img.shields.io/cocoapods/v/DWTransform.svg?style=flat)](http://cocoapods.org/?q=DWTransform)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/DWTransform.svg?style=flat)](http://cocoapods.org/?q=DWTransform)&nbsp;
[![License](https://img.shields.io/cocoapods/l/DWTransform.svg?style=flat)](http://cocoapods.org/pods/DWTransform) 
[![GitHub stars](https://img.shields.io/github/stars/dwanghello/DWTransform.svg)](https://github.com/asiosldh/DWTransform/stargazers)

![logo](https://github.com/dwanghello/DWTransform/blob/master/transform.png)
---
# Tip
- *新增同时设置多个元素的transform(17-05-16)*

---
### *如果感觉不错，请给个Star支持一下*
#### *使用中如果遇到什么问题可以联系我*
##### *QQ群:577506623*
![QQ群](https://github.com/dwanghello/DWTransform/blob/master/QQ群.png)
##### *e-mail:dwang.hello@outlook.com*

---
*预览|Preview*

![平移、旋转、缩放](https://github.com/dwanghello/DWTransform/blob/master/效果图/平移、旋转、缩放.gif)
![清除](https://github.com/dwanghello/DWTransform/blob/master/效果图/清除.gif)

---
*使用|USE*

- 现有组合方式
    - 平移|旋转|缩放|平移、旋转|平移、缩放|旋转、缩放|平移、旋转、缩放
        - 不带动画
        - 多个元素不带动画
        - 不带动画累计
        - 多个元素不带动画累计
        - 带动画
        - 多个元素带动画
        - 带动画累计
        - 多个元素带动画累计
        
---
- Cocopods
    - *pod 'DWTransform', '~> 0.0.3'*
    - 无法search或search到不是最新的库:[解决方案](http://www.jianshu.com/p/1fc730b0edc7)
    
---
### 以平移为例

    /**
    不带动画平移

    @param tx X轴的平移数
    @param ty Y轴的平移数
    @param view 添加平移的所在对象
    */
    [DWTransform dwTransformMakeTranslationTX:50 TY:50 toView:self.transformView];

---
    /**
    不带动画累计平移
    
    @param tx X轴的平移数
    @param ty Y轴的平移数
    @param view 添加平移的所在对象
    */
    [DWTransform dwCumulativeTransformMakeTranslationTX:50 TY:50 toView:self.transformView];

---
    /**
    带动画平移

    @param tx X轴的平移数
    @param ty Y轴的平移数
    @param view 添加平移的所在对象
    @param duration 动画执行时间
    @param completion 动画执行完成之后的回调
    */
    [DWTransform dwTransformMakeTranslationTX:25 TY:25 toView:self.transformView animateWithDuration:Duration completion:^(BOOL finished) {
            NSLog(@"移动完成");
    }];

---
    /**
     带动画累计平移
 
     @param tx X轴的平移数
     @param ty Y轴的平移数
     @param view 添加平移的所在对象
     @param duration 动画执行时间
     @param completion 动画执行完成之后的回调
     */
    [DWTransform dwCumulativeTransformMakeTranslationTX:25 TY:25 toView:self.transformView animateWithDuration:Duration completion:^(BOOL finished) {
            NSLog(@"移动完成");
    }];

---
    /**
    多个元素不带动画平移

    @param tx X轴的平移数
    @param ty Y轴的平移数
    @param views 添加平移的所在对象数组
    */
    [DWTransform dwTransformMakeTranslationTX:50 TY:50 toViews:@[view1, view2]];
    
 ---
     /**
     多个元素不带动画累计平移

     @param tx X轴的平移数
     @param ty Y轴的平移数
     @param views 添加平移的所在对象数组
     */
     [DWTransform dwCumulativeTransformMakeTranslationTX:50 TY:50 toViews:@[view1, view2]];
     
---
    /**
    多个元素带动画平移
 
    @param tx X轴的平移数
    @param ty Y轴的平移数
    @param views 添加平移的所在对象数组
    @param duration 动画执行时间
     @param completion 动画执行完成之后的回调
    */
     [DWTransform dwTransformMakeTranslationTX:50 TY:50 toViews:trnasArr animateWithDuration:Duration completion:^(BOOL finished) {
                        NSLog(@"多个元素带动画平移完成");
                    }];
                    
---
    /**
     多个元素带动画累计平移

     @param tx X轴的平移数
     @param ty Y轴的平移数
     @param views 添加平移的所在对象数组
     @param duration 动画执行时间
     @param completion 动画执行完成之后的回调
     */
     [DWTransform dwCumulativeTransformMakeTranslationTX:50 TY:50 toViews:trnasArr animateWithDuration:Duration completion:^(BOOL finished) {
                        NSLog(@"多个元素带动画累计平移完成");
                    }];
