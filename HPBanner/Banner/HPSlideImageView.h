//
//  SlideImageView.h
//  SingularityLive
//
//  Created by 何鹏 on 17/4/9.
//  Copyright © 2017年 messcat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPShowType.h"

#define HPSlideImage [HPSlideImageView new]

@class HPContent;
@class HPSetObj;


typedef HPSetObj *(^SET_SlideImage)(id weakObj,HPSetObj *hpSetObj);
typedef HPContent *(^CHANGE_IndexPath)(id weakObj,HPContent *content,NSUInteger index);
typedef void (^ACTIONIMAGEVIEW)(id weakObj,NSUInteger index);

@interface HPSlideImageView : UIView


/**
 设置轮播图

 @param weakObj 需要在block回调的弱引用对象
 @param setBlock 设置轮播图样式和数据源
 @param actionBlock 点击轮播图
 @param indexBlock 动态设置状态
 */
-(void)hp_weakObj:(id)weakObj
    setSlideImage:(SET_SlideImage)setBlock
           action:(ACTIONIMAGEVIEW)actionBlock
        indexPath:(CHANGE_IndexPath)indexBlock;


/**
 刷新 会执行 SET_SlideImage setBlock
 */
-(void)updateLayout;


@end

@interface HPSetObj : NSObject

/**
 是否需要动画
 */
@property(nonatomic,assign) BOOL animation;

/**
 样式
 */
@property(nonatomic,assign) HPSlideImageViewType style;

/**
 数据源 只支持 UIImage NSString
 */
@property(nonatomic,strong) NSArray *arrayImage;


/**
 底部view颜色
 */
@property(nonatomic,strong) UIColor *bottomColor;

/**
 pageControl 颜色
 */
@property(nonatomic,strong) UIColor *pageColor;


/**
 修改bottom的位置

 @param addView 添加到那个view
 @param bottomRect 相对于addview的位置
 */
-(void)bottomAddSubview:(UIView *)addView bottomRect:(CGRect)bottomRect;

@end


@interface HPContent: UIView


/**
 动态在底部view显示的问题
 */
@property(nonatomic,strong) NSString *name;

@end
