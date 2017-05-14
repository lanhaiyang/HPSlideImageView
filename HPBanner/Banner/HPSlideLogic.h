//
//  HPSlideLogic.h
//  SingularityLive
//
//  Created by 何鹏 on 17/4/21.
//  Copyright © 2017年 messcat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HPSlideImageView;

typedef void(^CHANGE_CURRENT)(id weakObj,NSInteger leftCurrenNumber,NSInteger currenNumber,NSInteger rightCurrenNumber) ;

@interface HPSlideLogic : UIView


/**
 设置滑动 逻辑

 @param weakObj 需要在block弱引用的对象
 @param slideViewWidth Banner 底部的View宽度
 @param scrollView  滑动的scrollView
 @param currentIndex 当前imageView位置 需要一个指针
 @param arrayDataCount  图片的个数
 @param changeBlock 改变设置的block
 */
+(void)hp_weakObj:(id)weakObj
   slideSuperView:(CGFloat)slideViewWidth
       scrollView:(UIScrollView *)scrollView
     currentIndex:(NSUInteger *)currentIndex
        dataArray:(NSUInteger )arrayDataCount
     changeNumber:(CHANGE_CURRENT)changeBlock;


/**
 获得越界对象

 @param arrayData 数据源
 @param index 当前位置
 @return 返回对应位置的数据
 */
+(id )arrayData:(NSArray *)arrayData currenInde:(NSInteger)index;


/**
 办到是否有数据

 @param dataArray 数据源
 @return 返回是否有数据
 */
+(NSUInteger)alphaArray:(NSArray *)dataArray;

@end
