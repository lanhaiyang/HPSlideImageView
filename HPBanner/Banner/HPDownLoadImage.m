//
//  HPDownLoadImage.m
//  HPBanner
//
//  Created by 何鹏 on 17/5/23.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import "HPDownLoadImage.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HPDownLoadImage ()

@end

@implementation HPDownLoadImage

+(void)imageViewSetImage:(UIImageView *)imageView
                  setObj:(id)Obj
         imageLoadStatus:(IMAGESTATUS)loadStatus
    downloadDefaultImage:(UIImage *)defaultImage
{
    if ([Obj isKindOfClass:[NSString class]])
    {
        NSString *imageUrl=Obj;
        
        if (defaultImage==nil) {
            defaultImage=[UIImage imageNamed:@""];
        }
        
        switch (loadStatus) {
            case HP_ENUM_LoadWeb:
            {
                [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:defaultImage];
            }
                break;
            case HP_ENUM_LeadyLoadWeb:
            {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image=defaultImage;
                });
                
                [self gifAndImage:imageUrl
                        imageView:imageView];
            }
                break;
            default:
                break;
        }
        
        
        
    }
    else if([Obj isKindOfClass:[UIImage class]])
    {
        UIImage *image=Obj;
        imageView.image=image;
    }
}

+(void)gifAndImage:(NSString *)path
         imageView:(UIImageView *)imageView
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:path]];
    SDImageCache* cache = [SDImageCache sharedImageCache];
    //此方法会先从memory中取。
     UIImage *image = [cache imageFromDiskCacheForKey:key];
    
    UIImage *imageGif=nil;
    
    if (image==nil) {
        return;
    }
    else
    {
        if (image.images.count==0) {
            imageGif=image;
        }
        else
        {
            imageGif=[image.images[0] copy];
            image=nil;
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        imageView.image=imageGif;
    });
    
}


@end
