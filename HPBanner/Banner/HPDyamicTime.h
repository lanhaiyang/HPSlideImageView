//
//  DyamicTime.h
//  SingularityLive
//
//  Created by 何鹏 on 17/4/21.
//  Copyright © 2017年 messcat. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ChangeTime)(id weakObj);
typedef void (^stopTime)(id weakObj);

@interface HPDyamicTime : NSObject

//创建时间对象
+(instancetype)createTime;


/**
 *  开启循环
 *  @param weakObj 需要弱引用的对象
 *  @param intervalTime 动画时间间隔
 *  @param time     block 循环内容
 */
-(void)hpWeakObj:(id)weakObj openAnimationInterval:(NSTimeInterval )intervalTime block:(ChangeTime)time;

/**
 *  暂停循环
 */
-(void)stop;

/**
 *  停止后做的事情
 *
 *  @param stopBlock 操作
 */
-(void)stopBloc:(stopTime)stopBlock;


/**
 暂停
 */
-(void)pauseAnimtion;


/**
 继续
 */
-(void)continueAnimtion;

@end

