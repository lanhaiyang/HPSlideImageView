//
//  HPGesture.h
//  HPBanner
//
//  Created by 何鹏 on 17/4/22.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TAP_ACTION)(id weak,UITapGestureRecognizer *tap);

@interface HPGesture : UIView


/**
 设置手势

 @param weakObj 需要在block弱引用的对象
 @param tapView 作用在哪个view上
 @param tapClick 事件
 */
-(void)weakObj:(id)weakObj addTapView:(UIView *)tapView tapgesture:(TAP_ACTION)tapClick;


/**
 是否停止和开启手势

 @param openBool 开启和关闭
 */
-(void)tapGesture:(BOOL)openBool;

@end
