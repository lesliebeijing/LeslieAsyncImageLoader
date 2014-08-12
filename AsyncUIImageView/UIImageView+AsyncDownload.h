//
//  UIImageView+AsyncDownload.h
//  AsyncUIImageView
//
//  Created by Leslie.Fang on 14-8-11.
//  Copyright (c) 2014年 Enway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeslieAsyncImageDownloader.h"

// typedef void(^ImageDownloadedBlock)(UIImage *image, NSError *error, NSURL *imageURL);

@interface UIImageView (AsyncDownload)

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

@end
