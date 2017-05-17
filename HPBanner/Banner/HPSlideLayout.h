//
//  HPSlideLayout.h
//  HPBanner
//
//  Created by 何鹏 on 17/4/23.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPShowType.h"
@class HPSlideImageView;


@interface HPSlideLayout : UIView


/**
 对banner布局

 @param slideImageView Banner 底部的View宽度
 @param scrollView 滑动模块
 @param dataArray 数据源
 @param leftImageView 左边的imageView
 @param centerImageView 中间的imageView
 @param rightImageView 右边的imageView
 */
+(void)slideSuperView:(HPSlideImageView *)slideImageView
           scrollView:(UIScrollView *)scrollView
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
+(void)slideSuperView:(HPSlideImageView *)slideImageView
            styleType:(HPSlideImageViewType)style
            arrayData:(NSArray *)arrayData
           bottomView:(UIView *)bottmView
             pageView:(UIPageControl *)pageView
         contentLabel:(UILabel *)contentLabel;


/**
 设置图片

 @param imageView 需要显示内容的imageView
 @param Obj UIImage 或 NString 
 */
+(void)imageViewSetImage:(UIImageView *)imageView setObj:(id)Obj;

+(void)upView:(UIView *)upView addSubview:(UIView *)bottomView layoutRect:(CGRect)rect;

@end
