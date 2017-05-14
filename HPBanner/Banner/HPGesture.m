//
//  HPGesture.m
//  HPBanner
//
//  Created by 何鹏 on 17/4/22.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import "HPGesture.h"

@interface HPGesture ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)TAP_ACTION tapAction;
@property(nonatomic,strong)UITapGestureRecognizer *tapClick;

@property(nonatomic,weak) id hpWeakObj;

@end


@implementation HPGesture

-(void)weakObj:(id)weakObj addTapView:(UIView *)tapView tapgesture:(TAP_ACTION)tapClick;
{
    self.tapClick=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
    self.tapClick.delegate=self;
    self.tapAction=tapClick;
    [tapView addGestureRecognizer:self.tapClick];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}


-(void)actionTap:(UITapGestureRecognizer *)tap
{
    if (self.tapAction!=nil) {
        NSLog(@"By gesture catch");
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
