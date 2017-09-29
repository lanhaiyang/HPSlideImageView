//
//  HPEnum.h
//  HPBanner
//
//  Created by 何鹏 on 17/8/7.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#ifndef HPEnum_h
#define HPEnum_h

typedef enum {
    ENUM_HP_Horizontal=0,// -
    ENUM_HP_Vertical=1,// |
    
}HPSlideShowDirection;

typedef struct {
    
    CGFloat mainScalePrecent;
    CGFloat chileScalePrecent;
    
}HPSlideScale;

static inline
HPSlideScale HPSlideScaleMake(CGFloat mainScalePrecent,CGFloat chileScalePrecent)
{
    HPSlideScale scale;
    
    scale.mainScalePrecent=mainScalePrecent;
    scale.chileScalePrecent=chileScalePrecent;
    
    return scale;
}


#endif /* HPEnum_h */
