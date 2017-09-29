//
//  SlideImageView.h
//  SingularityLive
//
//  Created by 何鹏 on 17/4/9.
//  Copyright © 2017年 messcat. All rights reserved.
//

#import "HPSlideImageView.h"
#import "HPSlideLogic.h"
#import "UIView+HPGesture.h"
#import "HPSlideLayout.h"
#import "UIView+HPRect.h"
#import "HPDyamicTime.h"
#import "HPDownLoadImage.h"

@interface HPSlideImageView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIImageView *rightImageView;

@property(nonatomic,strong) UIScrollView *bannerScrollView;
@property(nonatomic,strong) UIView *bannerBackground;

@property(nonatomic,strong) UIView *bottomView;
@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,strong) UIPageControl *page;

@property(nonatomic,strong) CHANGE_IndexPath changeIndexBlock;
@property(nonatomic,strong) SET_SlideImage slideImageBlock;
@property(nonatomic,strong) ACTIONIMAGEVIEW imageViewActionBlock;
@property(nonatomic,weak) id chileWeakObj;

@property(nonatomic,strong) HPSetObj *hpObj;
@property(nonatomic,strong) HPContent *hpContent;
@property(nonatomic,strong) HPDyamicTime *time;


@end

@interface HPSetObj ()

@property(nonatomic,weak) UIView *subview;
@property(nonatomic,assign) CGRect bottomRect;
@property(nonatomic,assign) BOOL animation;

@end

@implementation HPSlideImageView
{
    NSUInteger currentIndex;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self creatScrollweakObj:_chileWeakObj slideSuperView:self dataArray:_hpObj];
}

-(void)hp_weakObj:(id)weakObj
    setSlideImage:(SET_SlideImage)setBlock
           action:(ACTIONIMAGEVIEW)actionBlock
        indexPath:(CHANGE_IndexPath)indexBlock
{
    _chileWeakObj=weakObj;
    _changeIndexBlock=indexBlock;
    _slideImageBlock=setBlock;
    _imageViewActionBlock=actionBlock;
    [self weakObj:weakObj layout:setBlock];
    [self weakObj:weakObj mageViewAction:actionBlock];
}

-(void)creatScrollweakObj:(id)weakObj
           slideSuperView:(HPSlideImageView *)slideImageView
                dataArray:(HPSetObj *)hpSetObj
{
    [HPSlideLayout visionDifference:_hpObj.visionDifference
                        slideSuperView:slideImageView
                         scrollView:self.bannerScrollView
              scrollVivewBackground:self.bannerBackground
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
    
    //update Bottom
    
    if (hpSetObj.subview!=nil) {
        [HPSlideLayout upView:hpSetObj.subview addSubview:self.bottomView layoutRect:hpSetObj.bottomRect];
    }
    
}

-(void)weakObj:(id)weakObj mageViewAction:(ACTIONIMAGEVIEW)actionBlock
{

    [_leftImageView weakObj:self tapgesture:^(id weak, UITapGestureRecognizer *tap) {
        
        if (actionBlock!=nil) {
            actionBlock(weakObj,currentIndex);
        }
        
    }];
    
    [_centerImageView weakObj:self tapgesture:^(id weak, UITapGestureRecognizer *tap) {
        
        if (actionBlock!=nil) {
            actionBlock(weakObj,currentIndex);
        }
        
    }];
}

-(void)updateLayout
{
    [self weakObj:_chileWeakObj layout:_slideImageBlock];
    [self weakObj:_chileWeakObj mageViewAction:_imageViewActionBlock];
}

-(void)weakObj:(id)weakObj layout:(SET_SlideImage)setBlock
{
    _hpObj.animation=YES;
    currentIndex=0;
    if (setBlock!=nil) {
        _hpObj=setBlock(weakObj,self.hpObj);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.layer.masksToBounds=YES;
        _bottomView.backgroundColor=_hpObj.bottomColor;
        _page.currentPageIndicatorTintColor=_hpObj.pageColor;
        _page.numberOfPages=_hpObj.arrayImage.count;
        _page.alpha=[HPSlideLogic alphaArray:_hpObj.arrayImage];
        _page.userInteractionEnabled=NO;
        
        _leftImageView.contentMode=_hpObj.contentModel;
        _centerImageView.contentMode=_hpObj.contentModel;
        _rightImageView.contentMode=_hpObj.contentModel;
        
        [self time:_hpObj];
    });
    
    [HPSlideLayout updateSlideWithArray:_hpObj.arrayImage
                       visionDifference:_hpObj.visionDifference
                         slideSuperView:self
                             scrollView:self.bannerScrollView
                            bottomLabel:self.contentLabel
                             addSubView:self.bannerBackground
                                   Left:self.leftImageView
                                 center:self.centerImageView
                                  right:self.rightImageView
                           updateLayout:^(NSUInteger index, IMAGESTATUS ststus, UIImageView *currentImageView) {
                               
                               [HPDownLoadImage imageViewSetImage:currentImageView
                                                           setObj:[HPSlideLogic arrayData:_hpObj.arrayImage currenInde:index]
                                                  imageLoadStatus:ststus
                                             downloadDefaultImage:self.hpObj.defaultImage];
                               
                               
                           }];
    
    if (_hpObj.arrayImage.count==0) {
        return;
    }
    
    [HPSlideImageView chileWeakObj:self.changeIndexBlock
                      labelContent:self.contentLabel
            changeWithContentBlock:self.changeIndexBlock
                      currenNumber:0];

    
}

-(void)time:(HPSetObj *)hpSetObj{
    
    if (hpSetObj.arrayImage.count<=1) {
        [_time stop];
        return ;
    }
    
    [_time stop];
    
    if (hpSetObj.animation==YES) {
        
        if (hpSetObj.animationTime==0) {
            hpSetObj.animationTime=5;
        }
        
        _time=[HPDyamicTime createTime];
        [_time hpWeakObj:self openAnimationInterval:hpSetObj.animationTime block:^(HPSlideImageView *weakObj) {
            
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
                endNumber:^(HPSlideImageView *weakObj, NSInteger leftCurrenNumber, NSInteger currenNumber, NSInteger rightCurrenNumber) {
                    
                    NSArray *arrayData=weakObj.hpObj.arrayImage;
                    
                    weakObj.page.currentPage=currenNumber;
                    [HPSlideImageView chileWeakObj:weakObj.changeIndexBlock
                                      labelContent:weakObj.contentLabel
                            changeWithContentBlock:weakObj.changeIndexBlock
                                      currenNumber:currenNumber];
                    
                    
                    [HPDownLoadImage imageViewSetImage:weakObj.leftImageView
                                                setObj:[HPSlideLogic arrayData:arrayData currenInde:leftCurrenNumber]
                                       imageLoadStatus:HP_ENUM_LeadyLoadWeb
                                  downloadDefaultImage:weakObj.hpObj.defaultImage];
                    
                    [HPDownLoadImage imageViewSetImage:weakObj.centerImageView
                                                setObj:[HPSlideLogic arrayData:arrayData currenInde:currenNumber]
                                       imageLoadStatus:HP_ENUM_LoadWeb
                                  downloadDefaultImage:weakObj.hpObj.defaultImage];
                    
                    [HPDownLoadImage imageViewSetImage:weakObj.rightImageView
                                                setObj:[HPSlideLogic arrayData:arrayData currenInde:rightCurrenNumber]
                                       imageLoadStatus:HP_ENUM_LeadyLoadWeb
                                  downloadDefaultImage:weakObj.hpObj.defaultImage];
                    
                    
                }];
    
    
    
    [_time continueAnimtion];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_time pauseAnimtion];
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [HPSlideLogic hp_weakObj:self
                   beignMove:_bannerScrollView.width
            visionDifference:_hpObj.visionDifference
                  scrollView:_bannerScrollView
                 changeBlock:^(HPSlideImageView *weakObj, HPSlideType slideType, CGFloat visionMove, CGFloat visionDistance) {
                     
                     [HPSlideLayout slideWithVisionChangeType:slideType
                                                   visionMove:visionMove
                                                 moveDistance:visionDistance
                                                   scrollView:weakObj.bannerScrollView
                                                         Left:weakObj.leftImageView
                                                       center:weakObj.centerImageView
                                                        right:weakObj.rightImageView];
                     
                 }];
}


+(void)chileWeakObj:(id)weakObj
       labelContent:(UILabel *)contentLabel
changeWithContentBlock:(CHANGE_IndexPath )indexPathBlock
       currenNumber:(NSUInteger)currenNumber
{
    
    if (indexPathBlock!=nil) {
        __block HPContent *content=[HPContent new];
        indexPathBlock(weakObj,content,currenNumber);
        dispatch_async(dispatch_get_main_queue(), ^{
           contentLabel.text=ObjNil(content.name,@"");
        content=nil;
        });
    
    }
}

#pragma mark - 懒加载

-(UIScrollView *)bannerScrollView
{
    if (_bannerScrollView==nil) {
        _bannerScrollView=[[UIScrollView alloc] init];
        _bannerScrollView.bounces=NO;
        _bannerScrollView.showsHorizontalScrollIndicator=NO;
        _bannerScrollView.pagingEnabled=YES;
        _bannerScrollView.delegate=self;
        _bannerScrollView.layer.masksToBounds=YES;
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

-(UIView *)bannerBackground
{
    if (_bannerBackground==nil) {
        _bannerBackground=[[UIView alloc] init];
    }
    return _bannerBackground;
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

-(CGFloat)visionDifference
{
    if (_visionDifference>1) {
        return 1.0;
    }
    else if(_visionDifference<0)
    {
        return 0;
    }
    return _visionDifference;
}


-(void)bottomAddSubview:(UIView *)addView bottomRect:(CGRect)bottomRect
{
    self.subview=addView;
    self.bottomRect=bottomRect;
}

-(void)setAnimationTime:(NSTimeInterval)animationTime
{
    if (animationTime<0) {
        _animation=NO;
        animationTime=-1;
        return;
    }
    else if(animationTime==0)
    {
        _animation=YES;
        _animationTime=5;
        return;
    }
    _animationTime=animationTime;
    _animation=YES;
}

@end

@implementation HPContent



@end


