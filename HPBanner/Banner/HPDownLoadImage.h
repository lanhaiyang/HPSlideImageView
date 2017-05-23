//
//  HPDownLoadImage.h
//  HPBanner
//
//  Created by 何鹏 on 17/5/23.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,IMAGESTATUS) {
    HP_ENUM_LeadyLoadWeb=1<<0,
    HP_ENUM_LoadWeb=1<<1
};

@interface HPDownLoadImage : UIImage

/**
 设置图片
 
 @param imageView 需要显示内容的imageView
 @param Obj UIImage 或 NString
 @param loadStatus 设置当前是否需要里面加载
 @param defaultImage 设置默认图片
 */
+(void)imageViewSetImage:(UIImageView *)imageView
                  setObj:(id)Obj
         imageLoadStatus:(IMAGESTATUS)loadStatus
    downloadDefaultImage:(UIImage *)defaultImage;

@end
