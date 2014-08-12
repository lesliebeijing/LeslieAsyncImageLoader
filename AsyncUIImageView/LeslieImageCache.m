//
//  LeslieImageCache.m
//  AsyncUIImageView
//
//  Created by Leslie.Fang on 14-8-11.
//  Copyright (c) 2014年 Enway. All rights reserved.
//

#import "LeslieImageCache.h"

@implementation LeslieImageCache

+(LeslieImageCache*)sharedCache {
    static LeslieImageCache *imageCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageCache = [[self alloc] init];
    });
    
    return imageCache;
}

-(id)init{
    if (self == [super init]) {
        ioQueue = dispatch_queue_create("com.leslie.LeslieImageCache", DISPATCH_QUEUE_SERIAL);
        
        memCache = [[NSCache alloc] init];
        memCache.name = @"image_cache";
        
        fileManager = [NSFileManager defaultManager];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        cacheDir = [paths objectAtIndex:0];
    }
    
    return self;
}

-(void)cacheImageToMemory:(UIImage*)image forKey:(NSString*)key{
    if (image) {
        [memCache setObject:image forKey:key];
    }
}

-(UIImage*)getImageFromMemoryForkey:(NSString*)key{
    return [memCache objectForKey:key];
}

-(void)cacheImageToFile:(UIImage*)image forKey:(NSString*)key ofType:(NSString*)imageType{
    if (!image || !key ||!imageType) {
        return;
    }
    
    dispatch_async(ioQueue, ^{
        // @"http://lh4.ggpht.com/_loGyjar4MMI/S-InbXaME3I/AAAAAAAADHo/4gNYkbxemFM/s144-c/Frantic.jpg"
        // 从 url 中分离出文件名 Frantic.jpg
        NSRange range = [key rangeOfString:@"/" options:NSBackwardsSearch];
        NSString *filename = [key substringFromIndex:range.location+1];
        NSString *filepath = [cacheDir stringByAppendingPathComponent:filename];
        NSData *data = nil;
        
        if ([imageType isEqualToString:@"jpg"]) {
            data = UIImageJPEGRepresentation(image, 1.0);
        }else{
            data = UIImagePNGRepresentation(image);
        }
        
        if (data) {
            [data writeToFile:filepath atomically:YES];
        }
    });
}

-(UIImage*)getImageFromFileForKey:(NSString*)key{
    if (!key) {
        return nil;
    }
    
    NSRange range = [key rangeOfString:@"/" options:NSBackwardsSearch];
    NSString *filename = [key substringFromIndex:range.location+1];
    NSString *filepath = [cacheDir stringByAppendingPathComponent:filename];
    
    if ([fileManager fileExistsAtPath:filepath]) {
        UIImage *image = [UIImage imageWithContentsOfFile:filepath];
        return image;
    }
    
    return nil;
}

@end
