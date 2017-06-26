//
//  HPSlideLogic.h
//  SingularityLive
//
//  Created by 何鹏 on 17/4/21.
//  Copyright © 2017年 messcat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPShowType.h"

typedef void(^END_CURRENT)(id weakObj,NSInteger leftCurrenNumber,NSInteger currenNumber,NSInteger rightCurrenNumber) ;
typedef void(^CHANGE_CURRENT) (id weakObj,HPSlideType slideType,CGFloat visionMove,CGFloat visionDistance);

@interface HPSlideLogic : UIView


/**
 设置滑动 结束时逻辑

 @param weakObj 需要在block弱引用的对象
 @param slideViewWidth Banner 底部的View宽度
 @param scrollView  滑动的scrollView
 @param currentIndex 当前imageView位置 需要一个指针
 @param arrayDataCount  图片的个数
 @param endBlock 结束设置的block
 */
+(void)hp_weakObj:(id)weakObj
   slideSuperView:(CGFloat)slideViewWidth
       scrollView:(UIScrollView *)scrollView
     currentIndex:(NSUInteger *)currentIndex
        dataArray:(NSUInteger )arrayDataCount
     endNumber:(END_CURRENT)endBlock;


/**
 改变时产生视觉差

 @param weakObj 需要在block弱引用的对象
 @param scrollerBeignMove 开始拖动的位置
 @param visionDifferenceNums 视觉差的范围
 @param scrollView 滑动的scrollView
 @param changeBlock 改变修改位置的block
 */
+(void)hp_weakObj:(id)weakObj
        beignMove:(CGFloat)scrollerBeignMove
 visionDifference:(CGFloat)visionDifferenceNums
    scrollView:(UIScrollView *)scrollView
       changeBlock:(CHANGE_CURRENT)changeBlock;


/**
 获得越界对象

 @param arrayData 数据源
 @param index 当前位置
 @return 返回对应位置的数据
 */
+(id )arrayData:(NSArray *)arrayData currenInde:(NSInteger)index;


/**
 是否有数据

 @param dataArray 数据源
 @return 返回是否有数据
 */
+(NSUInteger)alphaArray:(NSArray *)dataArray;

@end
