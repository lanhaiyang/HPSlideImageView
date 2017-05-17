//
//  ViewController.m
//  HPBanner
//
//  Created by 何鹏 on 17/4/22.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import "ViewController.h"
#import "HPSlideImageView.h"

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HPSlideImageView *slideImageView=[[HPSlideImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [self.view addSubview:slideImageView];
    
    NSArray *arrayDataString=@[@"http://scimg.jb51.net/allimg/150629/14-1506291A242927.jpg",
                               @"http://pic.58pic.com/58pic/14/27/45/71r58PICmDM_1024.jpg",
                               @"http://scimg.jb51.net/allimg/160316/14-160316145129313.jpg",
                               @"http://img1.3lian.com/2015/w7/85/d/21.jpg"];
    NSArray *arrayDataName=@[@"夏威夷",@"威尼斯",@"秋天风景",@"碧蓝湖"];
    
    [slideImageView hp_weakObj:self
                 setSlideImage:^HPSetObj *(ViewController *weakObj, HPSetObj *hpSetObj) {
                     
                     hpSetObj.animation=YES;
                     hpSetObj.bottomColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
                     hpSetObj.style=ENUM_HP_RightContentANDRightPageControl;
                     hpSetObj.arrayImage=arrayDataString;//数据源
                     
                     return hpSetObj;
                     
                 } action:^(id weakObj, NSUInteger index) {
                     NSLog(@"点击%ld",index);
                 } indexPath:^HPContent *(id weakObj, HPContent *content, NSUInteger index) {
                     
                     content.name=arrayDataName[index];
                     return content;
                     
                 }];
    
    //[slideImageView updateLayout];
    

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
