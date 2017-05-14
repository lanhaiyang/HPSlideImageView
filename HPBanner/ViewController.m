//
//  ViewController.m
//  HPBanner
//
//  Created by 何鹏 on 17/4/22.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import "ViewController.h"
#import "HPSlideImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HPSlideImageView *slideImageView=[HPSlideImageView new];
    
    [slideImageView hp_weakObj:self
               setSlideImage:^HPSetObj *(id weakObj, HPSetObj *hpSetObj) {
                   
                   hpSetObj.animation=YES;
                   hpSetObj.style=ENUM_HP_RightPageControl;
//                   hpSetObj.arrayImage//数据源 
                   
                   return hpSetObj;
                   
               } action:^(id weakObj, NSUInteger index) {
                   NSLog(@"点击");
               } indexPath:^HPContent *(id weakObj, HPContent *content, NSUInteger index) {
                   
                   content.name=@"你好";
                   return content;
                   
               }];
    
    [slideImageView updateLayout];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
