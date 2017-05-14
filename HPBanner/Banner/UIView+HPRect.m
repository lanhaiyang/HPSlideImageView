//
//  UIView+Rect.m
//  ShiSanHang
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import "UIView+HPRect.h"

@implementation UIView (HPRect)

-(void)setWidth:(CGFloat)width
{
    self.bounds=CGRectMake(0, 0, width, self.height);
}

-(void)setHeight:(CGFloat)height
{
    self.bounds=CGRectMake(0, 0, self.width, height);
}


-(void)setX:(CGFloat)x
{
    self.frame=CGRectMake(x, self.y, self.width, self.height);
}

-(void)setY:(CGFloat)y
{
    self.frame=CGRectMake(self.x, y, self.width, self.height);
}


-(CGFloat)x
{
    return self.frame.origin.x;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}

-(CGFloat)width
{
    return self.bounds.size.width;
}

-(CGFloat)height
{
    return self.bounds.size.height;
}



@end
