//
//  DyamicTime.m
//  SingularityLive
//
//  Created by 何鹏 on 17/4/21.
//  Copyright © 2017年 messcat. All rights reserved.
//

#import "DyamicTime.h"

@interface DyamicTime ()

@property(nonatomic,strong)NSTimer *timer_ChangeContext;

@property(nonatomic,strong)ChangeTime changeTime;

@property(nonatomic,strong) id hpWeakObj;

@property(nonatomic,assign) BOOL boolPause;

@property(nonatomic,assign) NSTimeInterval timeInterval;

@end

@implementation DyamicTime

+(instancetype)createTime
{
    return [[DyamicTime alloc] init];
}

-(void)hpWeakObj:(id)weakObj openAnimationInterval:(NSTimeInterval )intervalTime block:(ChangeTime)time
{
    _hpWeakObj=weakObj;
    [self creatTimeInterval:intervalTime block:time];
}

-(void)stop
{
    [self animationStop];
}

-(void)stopBloc:(stopTime)stopBlock
{
    [self animationStopBlock:stopBlock];
}

-(void)creatTimeInterval:(NSTimeInterval)interval
                   block:(ChangeTime)time
{
    _changeTime=time;
    _timeInterval=interval;
    _timer_ChangeContext=[NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(changeTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer_ChangeContext forMode:NSRunLoopCommonModes];
    
}

-(void)animationStopBlock:(stopTime)stopBlock
{
    stopBlock(_hpWeakObj);
    [self animationStop];
}

-(void)animationStop
{
    [_timer_ChangeContext invalidate];//暂停时间
    _timer_ChangeContext=nil;
}

-(void)changeTimer:(NSTimer *)time
{
    if (_changeTime!=nil) {
        _changeTime(_hpWeakObj);
    }
}

-(void)pauseAnimtion
{
    _boolPause=YES;
    [self.timer_ChangeContext setFireDate:[NSDate distantFuture]];
}

-(void)continueAnimtion
{
    if (_boolPause==YES) {
        _boolPause=NO;
    }
    else
    {
        return;
    }
    
    [_timer_ChangeContext setFireDate:[NSDate dateWithTimeIntervalSinceNow:_timeInterval]];
    
}


@end

