//
//  LeslieImageCache.h
//  AsyncUIImageView
//
//  Created by Leslie.Fang on 14-8-11.
//  Copyright (c) 2014年 Enway. All rights reserved.

/**
 * 图片缓存类，单例模式
 * 实现二级缓存，一键内存缓存， NSCache 实现
 * 二级文件缓存
 */
#import <Foundation/Foundation.h>

@interface LeslieImageCache : NSObject{
@private
    NSCache *memCache;
    NSFileManager *fileManager;
    NSString *cacheDir;
    dispatch_queue_t ioQueue;
}

+(LeslieImageCache*)sharedCache;

// 内存缓存
-(void)cacheImageToMemory:(UIImage*)image forKey:(NSString*)key;
-(UIImage*)getImageFromMemoryForkey:(NSString*)key;

// 文件缓存
-(void)cacheImageToFile:(UIImage*)image forKey:(NSString*)key ofType:(NSString*)imageType;
-(UIImage*)getImageFromFileForKey:(NSString*)key;

@end
