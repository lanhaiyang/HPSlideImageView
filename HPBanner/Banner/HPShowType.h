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

#endif /* HPShowType_h */
