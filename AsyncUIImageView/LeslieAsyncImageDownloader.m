//
//  LeslieAsyncImageDownloader.m
//  AsyncUIImageView
//
//  Created by Leslie.Fang on 14-8-11.
//  Copyright (c) 2014年 Enway. All rights reserved.
//

#import "LeslieAsyncImageDownloader.h"

@implementation LeslieAsyncImageDownloader

+(id)sharedImageLoader{
    static LeslieAsyncImageDownloader *sharedImageLoader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedImageLoader = [[self alloc] init];
    });
    
    return sharedImageLoader;
}

- (void)downloadImageWithURL:(NSURL *)url complete:(ImageDownloadedBlock)completeBlock{
    LeslieImageCache *imageCache = [LeslieImageCache sharedCache];
    NSString *imageUrl = [url absoluteString];
    UIImage *image = [imageCache getImageFromMemoryForkey:imageUrl];
    // 先从内存中取
    if (image) {
        if (completeBlock) {
            NSLog(@"image exists in memory");
            completeBlock(image,nil,url);
        }
        
        return;
    }
    
    // 再从文件中取
    image = [imageCache getImageFromFileForKey:imageUrl];
    if (image) {
        if (completeBlock) {
            NSLog(@"image exists in file");
            completeBlock(image,nil,url);
        }
        
        // 重新加入到 NSCache 中
        [imageCache cacheImageToMemory:image forKey:imageUrl];
        
        return;
    }
    
    // 内存和文件中都没有再从网络下载
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError * error;
        NSData *imgData = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imgData];
            
            if (image) {
                // 先缓存图片到内存
                [imageCache cacheImageToMemory:image forKey:imageUrl];
                
                // 再缓存图片到文件系统
                NSString *extension = [[imageUrl substringFromIndex:imageUrl.length-3] lowercaseString];
                NSString *imageType = @"jpg";
                
                if ([extension isEqualToString:@"jpg"]) {
                    imageType = @"jpg";
                }else{
                    imageType = @"png";
                }
                
                [imageCache cacheImageToFile:image forKey:imageUrl ofType:imageType];
            }
            
            if (completeBlock) {
                completeBlock(image,error,url);
            }
        });
    });
}

@end
