//
//  HPSlideLayout.h
//  HPBanner
//
//  Created by 何鹏 on 17/4/23.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPShowType.h"

typedef void (^SlideUpdataBlock)(NSUInteger index,IMAGESTATUS ststus,UIImageView *currentImageView);

@interface HPSlideLayout : UIView



/**
 对banner布局

 @param visionDifferenceNum 视觉差设置参数
 @param slideImageView Banner 底部的View宽度
 @param scrollView 滑动模块
 @param background 滑块上面的布局
 @param dataArray 数据源
 @param leftImageView 左边的imageView
 @param centerImageView 中间的imageView
 @param rightImageView 右边的imageView
 */
+(void)visionDifference:(CGFloat )visionDifferenceNum
         slideSuperView:(UIView *)slideImageView
             scrollView:(UIScrollView *)scrollView
  scrollVivewBackground:(UIView *)background
              dataArray:(NSArray *)dataArray
                   left:(UIImageView *)leftImageView
                 center:(UIImageView *)centerImageView
                  right:(UIImageView *)rightImageView;


/**
 对bottomView布局

 @param slideImageView Banner 底部的View宽度
 @param style 样式
 @param arrayData 数据源
 @param bottmView 底部的View
 @param pageView pageControl
 @param contentLabel 底部View对应图片需要显示的内容
 */
+(void)slideSuperView:(UIView *)slideImageView
            styleType:(HPSlideImageViewType)style
            arrayData:(NSArray *)arrayData
           bottomView:(UIView *)bottmView
             pageView:(UIPageControl *)pageView
         contentLabel:(UILabel *)contentLabel;


/**
 设置bottom的位置

 @param upView 在哪个view上面
 @param bottomView bottom view
 @param rect 相对一个view的rect
 */
+(void)upView:(UIView *)upView addSubview:(UIView *)bottomView layoutRect:(CGRect)rect;


/**
 设置视觉差效果布局

 @param slideType 滑动方向
 @param visionMove 按比例滑动长度
 @param distance  视觉差的出效果宽度
 @param scrollView 滑动的scrollview
 @param leftImageView 左边的imageView
 @param centerImageView 中间的imageView
 @param rightImageView 右边的imageView
 */
+(void)slideWithVisionChangeType:(HPSlideType)slideType
                      visionMove:(CGFloat )visionMove
                    moveDistance:(CGFloat)distance
                      scrollView:(UIScrollView *)scrollView
                            Left:(UIImageView *)leftImageView
                          center:(UIImageView *)centerImageView
                           right:(UIImageView *)rightImageView;


/**
 更新布局

 @param updateArray 数据源
 @param visionDifferenceNum 视觉差
 @param slideImageView HPSlideImageView对象
 @param scrollView scrollView对象
 @param bottomLabel bottom上面的对象
 @param view  scrollView上面的背景
 @param leftImageView 左边的imageView
 @param centerImageView 中间的imageView
 @param rightImageView 右边的imageView
 @param slideUpdateBlock 主视图更新布局block
 */
+(void)updateSlideWithArray:(NSArray *)updateArray
           visionDifference:(CGFloat )visionDifferenceNum
             slideSuperView:(UIView *)slideImageView
                 scrollView:(UIScrollView *)scrollView
                bottomLabel:(UILabel *)bottomLabel
                 addSubView:(UIView *)view
                       Left:(UIImageView *)leftImageView
                     center:(UIImageView *)centerImageView
                      right:(UIImageView *)rightImageView
               updateLayout:(SlideUpdataBlock)slideUpdateBlock;




@end
