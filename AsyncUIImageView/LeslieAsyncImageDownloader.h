//
//  LeslieAsyncImageDownloader.h
//  AsyncUIImageView
//
//  Created by Leslie.Fang on 14-8-11.
//  Copyright (c) 2014年 Enway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeslieImageCache.h"

typedef void(^ImageDownloadedBlock)(UIImage *image, NSError *error, NSURL *imageURL);


@interface LeslieAsyncImageDownloader : NSObject

+(id)sharedImageLoader;

- (void)downloadImageWithURL:(NSURL *)url complete:(ImageDownloadedBlock)completeBlock;

@end
