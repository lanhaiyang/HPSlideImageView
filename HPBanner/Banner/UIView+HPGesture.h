//
//  UIView+Gesture.h
//  ShiSanHang
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TAP_ACTION)(id weak,UITapGestureRecognizer *tap);

@interface UIView (HPGesture)

/**
 设置手势
 
 @param weakObj 需要在block弱引用的对象
 @param tapClick 事件
 */
-(void)weakObj:(id)weakObj tapgesture:(TAP_ACTION)tapClick;

/**
 是否停止和开启手势
 
 @param openBool 开启和关闭
 */
-(void)tapGesture:(BOOL)openBool;

@end
