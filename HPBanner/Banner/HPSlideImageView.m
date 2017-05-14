//
//  SlideImageView.h
//  SingularityLive
//
//  Created by 何鹏 on 17/4/9.
//  Copyright © 2017年 messcat. All rights reserved.
//

#import "HPSlideImageView.h"
#import "HPSlideLogic.h"
#import "HPGesture.h"
#import "HPSlideLayout.h"
#import "UIView+HPRect.h"
#import "DyamicTime.h"

@interface HPSlideImageView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIImageView *rightImageView;

@property(nonatomic,strong) UIScrollView *bannerScrollView;

@property(nonatomic,strong) UIView *bottomView;
@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,strong) UIPageControl *page;

@property(nonatomic,strong) CHANGE_IndexPath changeIndexBlock;
@property(nonatomic,strong) SET_SlideImage slideImageBlock;
@property(nonatomic,weak) id chileWeakObj;

@property(nonatomic,strong) HPSetObj *hpObj;
@property(nonatomic,strong) HPContent *hpContent;
@property(nonatomic,strong) DyamicTime *time;

@end

@implementation HPSlideImageView
{
    NSUInteger currentIndex;
}


-(void)hp_weakObj:(id)weakObj
    setSlideImage:(SET_SlideImage)setBlock
           action:(ACTIONIMAGEVIEW)actionBlock
        indexPath:(CHANGE_IndexPath)indexBlock
{
    _chileWeakObj=weakObj;
    _changeIndexBlock=indexBlock;
    _slideImageBlock=setBlock;
    [self weakObj:weakObj layout:setBlock];
    [self creatScrollweakObj:weakObj slideSuperView:self dataArray:_hpObj];
    [self weakObj:weakObj mageViewAction:actionBlock];
}

-(void)creatScrollweakObj:(id)weakObj
           slideSuperView:(HPSlideImageView *)slideImageView
                dataArray:(HPSetObj *)hpSetObj
{
    [HPSlideLayout slideSuperView:slideImageView
                       scrollView:self.bannerScrollView
                        dataArray:hpSetObj.arrayImage
                             left:self.leftImageView
                           center:self.centerImageView
                            right:self.rightImageView];
    
    //add

    [HPSlideLayout slideSuperView:slideImageView
                        styleType:hpSetObj.style
                        arrayData:hpSetObj.arrayImage
                       bottomView:self.bottomView
                         pageView:self.page
                     contentLabel:self.contentLabel];
    
}

-(void)weakObj:(id)weakObj mageViewAction:(ACTIONIMAGEVIEW)actionBlock
{
    HPGesture *gesture=[HPGesture new];
    [gesture weakObj:self
          addTapView:_centerImageView
          tapgesture:^(HPSlideImageView *weak, UITapGestureRecognizer *tap) {
              
              if (actionBlock!=nil) {
                  actionBlock(weakObj,currentIndex);
              }
              
          }];
}

-(void)updateLayout
{
    [self weakObj:_chileWeakObj layout:_slideImageBlock];
}

-(void)weakObj:(id)weakObj layout:(SET_SlideImage)setBlock
{
    if (setBlock!=nil) {
        _hpObj=setBlock(weakObj,self.hpObj);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _bottomView.backgroundColor=_hpObj.bottomColor;
        _page.currentPageIndicatorTintColor=_hpObj.pageColor;
        _page.alpha=[HPSlideLogic alphaArray:_hpObj.arrayImage];
    });
    
    
    [HPSlideImageView chileWeakObj:self.changeIndexBlock
                      labelContent:self.contentLabel
            changeWithContentBlock:self.changeIndexBlock
                      currenNumber:0];
    
    [HPSlideLayout imageViewSetImage:self.leftImageView
                              setObj:[HPSlideLogic arrayData:_hpObj.arrayImage
                                                  currenInde:_hpObj.arrayImage.count-1]];
    [HPSlideLayout imageViewSetImage:self.centerImageView
                              setObj:[HPSlideLogic arrayData:_hpObj.arrayImage
                                                  currenInde:0]];
    [HPSlideLayout imageViewSetImage:self.rightImageView
                              setObj:[HPSlideLogic arrayData:_hpObj.arrayImage
                                                  currenInde:1]];
    [self time:_hpObj.animation];
}

-(void)time:(BOOL)animation{
    
    [_time stop];
    
    if (animation==YES) {
        
        _time=[DyamicTime createTime];
        
        [_time hpWeakObj:self openAnimationInterval:5 block:^(HPSlideImageView *weakObj) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.5 animations:^{
                    weakObj.bannerScrollView.contentOffset=CGPointMake(2*self.width, 0);
                }completion:^(BOOL finished) {
                    [weakObj scrollViewDidEndDecelerating:self.bannerScrollView];
                }];
            });
            
        }];
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [HPSlideLogic hp_weakObj:self
              slideSuperView:self.width
                  scrollView:scrollView
                currentIndex:&currentIndex
                   dataArray:_hpObj.arrayImage.count
                changeNumber:^(HPSlideImageView *weakObj, NSInteger leftCurrenNumber, NSInteger currenNumber, NSInteger rightCurrenNumber) {
                    
                    NSArray *arrayData=weakObj.hpObj.arrayImage;
                    
                    weakObj.page.currentPage=currenNumber;
                    [HPSlideImageView chileWeakObj:weakObj.changeIndexBlock
                                      labelContent:weakObj.contentLabel
                            changeWithContentBlock:weakObj.changeIndexBlock
                                      currenNumber:currenNumber];
                    
                    [HPSlideLayout imageViewSetImage:weakObj.leftImageView setObj:[HPSlideLogic arrayData:arrayData currenInde:leftCurrenNumber]];
                    [HPSlideLayout imageViewSetImage:weakObj.centerImageView setObj:[HPSlideLogic arrayData:arrayData currenInde:currenNumber]];
                    [HPSlideLayout imageViewSetImage:weakObj.rightImageView setObj:[HPSlideLogic arrayData:arrayData currenInde:rightCurrenNumber]];
                    
                }];
}

+(void)chileWeakObj:(id)weakObj labelContent:(UILabel *)contentLabel changeWithContentBlock:(CHANGE_IndexPath )indexPathBlock currenNumber:(NSUInteger)currenNumber
{
    if (indexPathBlock!=nil) {
        HPContent *content=[HPContent new];
        indexPathBlock(weakObj,content,currenNumber);
        dispatch_async(dispatch_get_main_queue(), ^{
           contentLabel.text=ObjNil(content.name,@"");
        });
        
        content=nil;
    }
}

#pragma mark - 懒加载

-(UIScrollView *)bannerScrollView
{
    if (_bannerScrollView==nil) {
        _bannerScrollView=[[UIScrollView alloc] init];
        _bannerScrollView.showsHorizontalScrollIndicator=NO;
        _bannerScrollView.pagingEnabled=YES;
        _bannerScrollView.delegate=self;
    }
    return _bannerScrollView;
}

-(UIImageView *)leftImageView
{
    if (_leftImageView==nil) {
        _leftImageView=[UIImageView new];
    }
    return _leftImageView;
}

-(UIImageView *)centerImageView
{
    if (_centerImageView==nil) {
        _centerImageView=[UIImageView new];
    }
    return _centerImageView;
}

-(UIImageView *)rightImageView
{
    if (_rightImageView==nil) {
        _rightImageView=[UIImageView new];
    }
    return _rightImageView;
}

-(UIView *)bottomView
{
    if (_bottomView==nil) {
        _bottomView=[UIView new];
    }
    return _bottomView;
}

-(UIPageControl *)page
{
    if (_page==nil) {
        _page=[UIPageControl new];
    }
    return _page;
}

-(UILabel *)contentLabel
{
    if (_contentLabel==nil) {
        _contentLabel=[UILabel new];
        _contentLabel.textColor=[UIColor whiteColor];
    }
    return _contentLabel;
}

-(HPContent *)hpContent
{
    if (_hpContent==nil) {
        _hpContent=[HPContent new];
    }
    return _hpContent;
}

-(HPSetObj *)hpObj
{
    if (_hpObj==nil) {
        _hpObj=[[HPSetObj alloc] init];
    }
    return _hpObj;
}

@end

#pragma mark - 设置对象

@implementation HPSetObj

-(UIColor *)bottomColor
{
    if (_bottomColor==nil) {
        _bottomColor=[UIColor clearColor];
    }
    return _bottomColor;
}

-(UIColor *)pageColor
{
    if (_pageColor==nil) {
        _pageColor=[UIColor orangeColor];
    }
    return _pageColor;
}

-(BOOL)animation
{
    return YES;
}


@end

@implementation HPContent



@end


