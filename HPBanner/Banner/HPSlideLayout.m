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
#import "HPSlideImageView.h"
#import "UIView+HPRect.h"

#define SizeNumber 3
#define bottmViewHeight 30
#define labelHeight 30
#define pageWeight 100


@implementation HPSlideLayout


+(void)slideSuperView:(HPSlideImageView *)slideImageView
           scrollView:(UIScrollView *)scrollView
            dataArray:(NSArray *)dataArray
                 left:(UIImageView *)leftImageView
               center:(UIImageView *)centerImageView
                right:(UIImageView *)rightImageView
{
    [slideImageView layoutIfNeeded];
    UIView *background=nil;
    
    background=[[UIView alloc] init];
    
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
        [self layoutArrayCountGreaterThanOneSlideSuperView:slideImageView
                                                scrollView:scrollView
                                            backgroundView:background
                                                      left:leftImageView
                                                    center:centerImageView
                                                     right:rightImageView];
    }
    
}

+(void)layoutArrayCountOneSlideSuperView:(HPSlideImageView *)slideImageView
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

+(void)layoutArrayCountGreaterThanOneSlideSuperView:(HPSlideImageView *)slideImageView
                                         scrollView:(UIScrollView *)scrollView
                                     backgroundView:(UIView *)backgroundView
                                               left:(UIImageView *)leftImageView
                                             center:(UIImageView *)centerImageView
                                              right:(UIImageView *)rightImageView
{
    scrollView.contentSize=CGSizeMake(SizeNumber*slideImageView.width, slideImageView.height);
    scrollView.contentOffset=CGPointMake(slideImageView.width, 0);
    backgroundView.frame=CGRectMake(0, 0, scrollView.contentSize.width, scrollView.height);
    if (leftImageView!=nil) {
        leftImageView.userInteractionEnabled=NO;
        leftImageView.frame=CGRectMake(0, 0, slideImageView.width, scrollView.height);
        [backgroundView addSubview:leftImageView];
    }
    
    if (centerImageView!=nil) {
        centerImageView.userInteractionEnabled=YES;
        centerImageView.frame=CGRectMake(slideImageView.width, 0, scrollView.width, scrollView.height);
        [backgroundView addSubview:centerImageView];
    }
    
    if (rightImageView!=nil) {
        rightImageView.userInteractionEnabled=NO;
        rightImageView.frame=CGRectMake(2*slideImageView.width, 0, scrollView.width, scrollView.height);
        [backgroundView addSubview:rightImageView];
    }
}

+(void)slideSuperView:(HPSlideImageView *)slideImageView
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

+(void)rightPageLayout:(UIView *)bottmView
              pageView:(UIPageControl *)pageView
{
    if (pageView!=nil) {
        CGFloat x=bottmView.width-(100+5);
        CGFloat y=bottmView.height/2-20/2;
        pageView.frame=CGRectMake(x, y, 100, 20);
        [bottmView addSubview:pageView];
    }
}

+(void)centerPageLayout:(UIView *)bottmView
               pageView:(UIPageControl *)pageView
{
    if (pageView!=nil) {
        CGFloat x=bottmView.width/2-100/2;
        CGFloat y=bottmView.height/2-20/2;
        pageView.frame=CGRectMake(x, y, 100, 20);
        [bottmView addSubview:pageView];
    }
}

+(void)leftPageLayout:(UIView *)bottmView
             pageView:(UIPageControl *)pageView
{
    if (pageView!=nil) {
        CGFloat x=5;
        CGFloat y=bottmView.height/2-20/2;
        pageView.frame=CGRectMake(x, y, 100, 20);
        [bottmView addSubview:pageView];
    }
}

+(void)leftContentANDRightPageLayout:(UIView *)bottmView
                            pageView:(UIPageControl *)pageView
                        contentLabel:(UILabel *)contentLabel
{
    if (pageView!=nil) {
        CGFloat x=bottmView.width-(100+5);
        CGFloat y=bottmView.height/2-20/2;
        pageView.frame=CGRectMake(x, y, 100, 20);
        [bottmView addSubview:pageView];
    }
    
    if (contentLabel!=nil) {
        CGFloat y=bottmView.height/2-labelHeight/2;
        CGFloat width=bottmView.width-pageView.width-10;
        contentLabel.frame=CGRectMake(20, y, width, 30);
        contentLabel.font=[UIFont systemFontOfSize:14];
        contentLabel.textAlignment=NSTextAlignmentLeft;
        [bottmView addSubview:contentLabel];
    }
}

+(void)rightContentANDRightPageLayout:(UIView *)bottmView
                             pageView:(UIPageControl *)pageView
                         contentLabel:(UILabel *)contentLabel
{
    
    if (contentLabel!=nil) {
        CGFloat y=bottmView.height/2-labelHeight/2;
        CGFloat x=pageView.width+pageView.x;
        CGFloat width=bottmView.width-pageView.width-10;
        contentLabel.frame=CGRectMake(x, y, width, 30);
        contentLabel.font=[UIFont systemFontOfSize:14];
        contentLabel.textAlignment=NSTextAlignmentLeft;
        [bottmView addSubview:contentLabel];
    }
}

+(void)imageViewSetImage:(UIImageView *)imageView setObj:(id)Obj
{
    if ([Obj isKindOfClass:[NSString class]])
    {
        NSString *imageUrl=Obj;
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
    }
    else if([Obj isKindOfClass:[UIImage class]])
    {
        UIImage *image=Obj;
        imageView.image=image;
    }
}

@end
