//
//  HPShowType.h
//  SingularityLive
//
//  Created by 何鹏 on 17/5/14.
//  Copyright © 2017年 messcat. All rights reserved.
//

#ifndef HPShowType_h
#define HPShowType_h

typedef NS_ENUM(NSInteger, HPSlideImageViewType) {
    ENUM_HP_RightPageControl=1<<0,
    ENUM_HP_CenterPageControl=1<<1,
    ENUM_HP_LeftPageControl=1<<2,//无内容 只显示pageControl
    ENUM_HP_LeftContentANDRightPageControl=1<<3,
    ENUM_HP_RightContentANDRightPageControl=1<<4
};

typedef NS_ENUM(NSInteger,HPSlideType){
    ENUM_HP_Right=1<<0,
    ENUM_HP_Center=1<<1,
    ENUM_HP_Left=1<<2
};

typedef NS_ENUM(NSUInteger,IMAGESTATUS) {
    HP_ENUM_LeadyLoadWeb=1<<0,
    HP_ENUM_LoadWeb=1<<1
};

//判断是否为空
#define ObjNil(__object,__notNil) __object!=nil?__object:__notNil

#endif /* HPShowType_h */
