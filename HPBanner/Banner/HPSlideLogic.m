//
//  HPSlideLogic.m
//  SingularityLive
//
//  Created by 何鹏 on 17/4/21.
//  Copyright © 2017年 messcat. All rights reserved.
//

#import "HPSlideLogic.h"
#import "UIView+HPRect.h"


@implementation HPSlideLogic


+(void)hp_weakObj:(id)weakObj
   slideSuperView:(CGFloat)slideViewWidth
       scrollView:(UIScrollView *)scrollView
     currentIndex:(NSUInteger *)currentIndex
        dataArray:(NSUInteger )arrayDataCount
     endNumber:(END_CURRENT)endBlock
{
    CGPoint off=[scrollView contentOffset];
    
    if (off.x==2*slideViewWidth) {
        //right
        
        NSUInteger currenNumber=*currentIndex+1;
        currenNumber=[self arrayDataWithPoint:arrayDataCount currenInde:currenNumber];
        *currentIndex=currenNumber;
        if (endBlock!=nil) {
            endBlock(weakObj,currenNumber-1,currenNumber,currenNumber+1);
        }
        
    }
    else if (off.x==0) {
        //left
        
        NSUInteger currenNumber=*currentIndex-1;
         currenNumber=[self arrayDataWithPoint:arrayDataCount currenInde:currenNumber];
        *currentIndex=currenNumber;
        if (endBlock!=nil) {
            endBlock(weakObj,currenNumber-1,currenNumber,currenNumber+1);
        }
        
    }
    
    
    scrollView.contentOffset=CGPointMake(slideViewWidth, 0);
}

+(void)hp_weakObj:(id)weakObj
        beignMove:(CGFloat)scrollerBeignMove
 visionDifference:(CGFloat)visionDifferenceNums
       scrollView:(UIScrollView *)scrollView
      changeBlock:(CHANGE_CURRENT)changeBlock;
{
    
    if (changeBlock==nil) {
        return;
    }
    
    CGFloat movePoint=scrollView.contentOffset.x-scrollerBeignMove;
    CGFloat percent=0;
    CGFloat visionMove=0;
    if (scrollView.bounds.size.width!=0) {
        percent=movePoint/scrollView.bounds.size.width;
        visionMove=scrollView.width*visionDifferenceNums;
    }
    CGFloat move=percent * visionMove;
    
    if (scrollView.contentOffset.x>scrollerBeignMove) {
        
        changeBlock(weakObj,ENUM_HP_Left,move,visionMove);
        
    }
    else if(scrollView.contentOffset.x<scrollerBeignMove)
    {
        
        changeBlock(weakObj,ENUM_HP_Right,move,visionMove);
        
    }
    else
    {
        changeBlock(weakObj,ENUM_HP_Center,0,visionMove);
    }
}

/**
    
 遇到边界

 */
+(id )arrayData:(NSArray *)arrayData currenInde:(NSInteger)index
{
    if (arrayData.count==0) {
        return nil;
    }
    index=[self arrayDataWithPoint:arrayData.count currenInde:index];
    
    return arrayData[index];
}

+(NSUInteger )arrayDataWithPoint:(NSUInteger )arrayDataCount currenInde:(NSInteger)index
{
    NSInteger count=arrayDataCount-1;
    if (index > count) {
        return  0;
    }
    if (index<0) {
        return arrayDataCount-1;
    }
    return index;
}

+(NSUInteger)alphaArray:(NSArray *)dataArray
{
    if (dataArray.count<=1) {
        return 0;
    }
    else
    {
        return 1;
    }
}

@end
