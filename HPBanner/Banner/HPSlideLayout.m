//
//  HPSlideLayout.m
//  HPBanner
//
//  Created by 何鹏 on 17/4/23.
//  Copyright © 2017年 何鹏. All rights reserved.
//

/*
 
 需要引入SDWebImage 
 如果是全局导入就不需要
 
 */

#import "HPSlideLayout.h"
#import "UIView+HPRect.h"

#define SizeNumber 3
#define bottmViewHeight 30
#define labelHeight 30
#define pageWeight 100


@implementation HPSlideLayout


+(void)visionDifference:(CGFloat )visionDifferenceNum
         slideSuperView:(UIView *)slideImageView
           scrollView:(UIScrollView *)scrollView
  scrollVivewBackground:(UIView *)background
            dataArray:(NSArray *)dataArray
                 left:(UIImageView *)leftImageView
               center:(UIImageView *)centerImageView
                right:(UIImageView *)rightImageView
{
    [slideImageView layoutIfNeeded];
    
    scrollView.frame=CGRectMake(0, 0, slideImageView.width, slideImageView.height);
    scrollView.contentOffset=CGPointMake(slideImageView.width, 0);
    
    [scrollView addSubview:background];
    [slideImageView addSubview:scrollView];
    
    if (dataArray.count==1) {
        [self layoutArrayCountOneSlideSuperView:slideImageView
                                     scrollView:scrollView
                                 backgroundView:background
                                           left:leftImageView
                                         center:centerImageView
                                          right:rightImageView];
    }
    else if(dataArray.count>1)
    {

        [self visionDifference:visionDifferenceNum
                slideSuperView:slideImageView
                    scrollView:scrollView
                backgroundView:background
                          left:leftImageView
                        center:centerImageView
                         right:rightImageView];
    }
    
}

+(void)layoutArrayCountOneSlideSuperView:(UIView *)slideImageView
                              scrollView:(UIScrollView *)scrollView
                          backgroundView:(UIView *)backgroundView
                                    left:(UIImageView *)leftImageView
                                  center:(UIImageView *)centerImageView
                                   right:(UIImageView *)rightImageView
{
    scrollView.contentSize=CGSizeMake(slideImageView.width, slideImageView.height);
    scrollView.contentOffset=CGPointMake(0, 0);
    backgroundView.frame=CGRectMake(0, 0, scrollView.contentSize.width, scrollView.height);
    
    if (leftImageView!=nil) {
        leftImageView.userInteractionEnabled=YES;
        leftImageView.frame=CGRectMake(0, 0, slideImageView.width, scrollView.height);
        [backgroundView addSubview:leftImageView];
    }
    
    centerImageView=nil;
    rightImageView=nil;
}

+(void)visionDifference:(CGFloat )visionDifferenceNum
         slideSuperView:(UIView *)slideImageView
             scrollView:(UIScrollView *)scrollView
         backgroundView:(UIView *)backgroundView
                   left:(UIImageView *)leftImageView
                 center:(UIImageView *)centerImageView
                  right:(UIImageView *)rightImageView
{
    
    CGFloat width=slideImageView.width*visionDifferenceNum;
    
    scrollView.contentSize=CGSizeMake(SizeNumber*slideImageView.width, slideImageView.height);
    scrollView.contentOffset=CGPointMake(slideImageView.width, 0);
    backgroundView.frame=CGRectMake(0, 0, scrollView.contentSize.width, scrollView.height);
    
    UIView *centerView=[[UIView alloc] init];
    
    if (leftImageView!=nil) {
        leftImageView.userInteractionEnabled=NO;
        leftImageView.frame=CGRectMake(width, 0, slideImageView.width, scrollView.height);
        [backgroundView addSubview:leftImageView];
    }
    
    if (centerImageView!=nil) {
        
        centerView.frame=CGRectMake(slideImageView.width, 0, scrollView.width, scrollView.height);
        centerView.clipsToBounds=YES;
        centerView.backgroundColor=[UIColor whiteColor];
        
        centerImageView.userInteractionEnabled=YES;
        centerImageView.frame=CGRectMake(0, 0, scrollView.width, scrollView.height);
        [centerView addSubview:centerImageView];
        [backgroundView addSubview:centerView];
    }
    
    if (rightImageView!=nil) {
        rightImageView.userInteractionEnabled=NO;
        rightImageView.frame=CGRectMake(2*slideImageView.width-width, 0, scrollView.width, scrollView.height);
        [backgroundView addSubview:rightImageView];
    }
    
    [backgroundView bringSubviewToFront:centerView];
}


+(void)slideSuperView:(UIView *)slideImageView
            styleType:(HPSlideImageViewType)style
            arrayData:(NSArray *)arrayData
           bottomView:(UIView *)bottmView
             pageView:(UIPageControl *)pageView
         contentLabel:(UILabel *)contentLabel
{
    if (bottmView!=nil) {
        CGFloat y=slideImageView.height-bottmViewHeight;
        bottmView.frame=CGRectMake(0, y, slideImageView.width, bottmViewHeight);
        [slideImageView addSubview:bottmView];
    }
    
    if (pageView!=nil) {
        pageView.numberOfPages=arrayData.count;
    }
    
    switch (style) {
        case ENUM_HP_LeftPageControl:
        {
            [self leftPageLayout:bottmView
                        pageView:pageView];
        }
            break;
        case ENUM_HP_CenterPageControl:
        {
            [self centerPageLayout:bottmView
                          pageView:pageView];
        }
            break;
        case ENUM_HP_RightPageControl:
        {
            [self rightPageLayout:bottmView
                         pageView:pageView];
        }
            break;
        case ENUM_HP_RightContentANDRightPageControl:
        {
            [self rightContentANDRightPageLayout:bottmView
                                        pageView:pageView
                                    contentLabel:contentLabel];
        }
            break;
        case ENUM_HP_LeftContentANDRightPageControl:
        {
            [self leftContentANDRightPageLayout:bottmView
                                       pageView:pageView
                                   contentLabel:contentLabel];
        }
            break;
        default:
            break;
    }
    

}

+(UIPageControl *)rightPageLayout:(UIView *)bottmView
              pageView:(UIPageControl *)pageView
{
    if (pageView!=nil) {
        CGFloat x=bottmView.width-(100+5);
        CGFloat y=bottmView.height/2-20/2;
        pageView.frame=CGRectMake(x, y, 100, 20);
        [bottmView addSubview:pageView];
    }
    
    return pageView;
}

+(UIPageControl *)centerPageLayout:(UIView *)bottmView
               pageView:(UIPageControl *)pageView
{
    if (pageView!=nil) {
        CGFloat x=bottmView.width/2-100/2;
        CGFloat y=bottmView.height/2-20/2;
        pageView.frame=CGRectMake(x, y, 100, 20);
        [bottmView addSubview:pageView];
    }
    
    return pageView;
}

+(UIPageControl *)leftPageLayout:(UIView *)bottmView
             pageView:(UIPageControl *)pageView
{
    if (pageView!=nil) {
        CGFloat x=5;
        CGFloat y=bottmView.height/2-20/2;
        pageView.frame=CGRectMake(x, y, 100, 20);
        [bottmView addSubview:pageView];
    }
    
    return pageView;
}

+(void)leftContentANDRightPageLayout:(UIView *)bottmView
                            pageView:(UIPageControl *)pageView
                        contentLabel:(UILabel *)contentLabel
{
    pageView=[self rightPageLayout:bottmView pageView:pageView];
    
    if (contentLabel!=nil) {
        CGFloat x=20;
        CGFloat y=bottmView.height/2-labelHeight/2;
        CGFloat width=bottmView.width-pageView.width-10-x-5;
        contentLabel.frame=CGRectMake(x, y, width, 30);
        contentLabel.font=[UIFont systemFontOfSize:14];
        contentLabel.textAlignment=NSTextAlignmentLeft;
        [bottmView addSubview:contentLabel];
    }
}

+(void)rightContentANDRightPageLayout:(UIView *)bottmView
                             pageView:(UIPageControl *)pageView
                         contentLabel:(UILabel *)contentLabel
{
    
    pageView=[self leftPageLayout:bottmView pageView:pageView];
    
    if (contentLabel!=nil) {
        CGFloat y=bottmView.height/2-labelHeight/2;
        CGFloat x=pageView.width+pageView.x+5;
        CGFloat width=bottmView.width-pageView.width-pageView.x-20;
        contentLabel.frame=CGRectMake(x, y, width, 30);
        contentLabel.font=[UIFont systemFontOfSize:14];
        contentLabel.textAlignment=NSTextAlignmentRight;
        [bottmView addSubview:contentLabel];
    }
}

+(void)slideWithVisionChangeType:(HPSlideType)slideType
                      visionMove:(CGFloat )visionMove
                    moveDistance:(CGFloat)distance
                      scrollView:(UIScrollView *)scrollView
                            Left:(UIImageView *)leftImageView
                          center:(UIImageView *)centerImageView
                           right:(UIImageView *)rightImageView
{
    switch (slideType) {
        case ENUM_HP_Left:
        {
            rightImageView.x=visionMove+(2*scrollView.width-distance);
            centerImageView.x=visionMove;
        }
            break;
        case ENUM_HP_Center:
        {
            rightImageView.x=2*scrollView.width-distance;
            centerImageView.x=0;
            leftImageView.x=distance;
        }
            break;
        case ENUM_HP_Right:
        {
            leftImageView.x=visionMove+distance;
            centerImageView.x=visionMove;
        }
            break;
        default:
            break;
    }
}

+(void)updateSlideWithArray:(NSArray *)updateArray
           visionDifference:(CGFloat )visionDifferenceNum
             slideSuperView:(UIView *)slideImageView
                 scrollView:(UIScrollView *)scrollView
                bottomLabel:(UILabel *)bottomLabel
                 addSubView:(UIView *)view
                       Left:(UIImageView *)leftImageView
                     center:(UIImageView *)centerImageView
                      right:(UIImageView *)rightImageView
               updateLayout:(SlideUpdataBlock)slideUpdateBlock
{
    if (updateArray.count==0) {
        
        [leftImageView removeFromSuperview];
        [centerImageView removeFromSuperview];
        [rightImageView removeFromSuperview];
        bottomLabel.text=@"";
    }
    else if(updateArray.count==1)
    {
        [self layoutArrayCountOneSlideSuperView:slideImageView
                                     scrollView:scrollView
                                 backgroundView:view
                                           left:leftImageView
                                         center:nil right:nil];
        [centerImageView removeFromSuperview];
        [rightImageView removeFromSuperview];
        
        if (slideUpdateBlock!=nil) {
            slideUpdateBlock(0,HP_ENUM_LoadWeb,leftImageView);
        }
    }
    else if(updateArray.count>1)
    {
        [self visionDifference:visionDifferenceNum
                slideSuperView:slideImageView
                    scrollView:scrollView
                backgroundView:view
                          left:leftImageView
                        center:centerImageView
                         right:rightImageView];
        if (slideUpdateBlock!=nil) {
            slideUpdateBlock(updateArray.count-1,HP_ENUM_LeadyLoadWeb,leftImageView);
            slideUpdateBlock(0,HP_ENUM_LoadWeb,centerImageView);
            slideUpdateBlock(1,HP_ENUM_LeadyLoadWeb,rightImageView);
        }
    }
}


+(void)upView:(UIView *)upView addSubview:(UIView *)bottomView layoutRect:(CGRect)rect
{
    bottomView.frame=rect;
    [upView addSubview:bottomView];
}

@end
