//
//  UIView+Gesture.m
//  ShiSanHang
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import "UIView+HPGesture.h"
#import <objc/runtime.h>

static void *tapActionKey = &tapActionKey;
static void *tapKey = &tapKey;
static void *hpWeakObj=&hpWeakObj;

@interface UIView ()

@property(nonatomic,strong)TAP_ACTION tapAction;
@property(nonatomic,strong)UITapGestureRecognizer *tapClick;

@property(nonatomic,weak) id hpWeakObj;

@end

@implementation UIView (HPGesture)

-(void)setHpWeakObj:(id)hpWeakObj
{
     objc_setAssociatedObject(self, &hpWeakObj, hpWeakObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)hpWeakObj
{
    return objc_getAssociatedObject(self, &hpWeakObj);
}

-(void)setTapAction:(TAP_ACTION)tapAction
{
    objc_setAssociatedObject(self, &tapActionKey, tapAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(TAP_ACTION)tapAction
{
    return objc_getAssociatedObject(self, &tapActionKey);
}

-(void)setTapClick:(UITapGestureRecognizer *)tapClick
{
    objc_setAssociatedObject(self, &tapKey, tapClick, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UITapGestureRecognizer *)tapClick
{
    return objc_getAssociatedObject(self, &tapKey);
}

-(void)weakObj:(id)weakObj tapgesture:(TAP_ACTION)tapClick
{
    if (self.userInteractionEnabled==NO) {
        return;
    }
    
    if (self.tapClick==nil) {
        self.tapClick=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
    }
    self.tapAction=tapClick;
    self.hpWeakObj=weakObj;
    [self addGestureRecognizer:self.tapClick];
}

-(void)actionTap:(UITapGestureRecognizer *)tap
{
    if (self.tapAction!=nil) {
        self.tapAction(self.hpWeakObj,tap);
    }
    else
    {
        NSLog(@"click not method");
    }
}

-(void)tapGesture:(BOOL)openBool
{
    if (openBool==NO) {
        self.tapClick.enabled=NO;
    }
    else
    {
        self.tapClick.enabled=YES;
    }
}


@end
