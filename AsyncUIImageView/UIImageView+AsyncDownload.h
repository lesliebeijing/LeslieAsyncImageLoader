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

// 通过为 ImageView 设置 tag 防止错位
// tag 指向的永远是当前可见图片的 url， 这样通过 tag 就可以过滤掉已经滑出屏幕的图片的 url
@property NSString *tag;

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

@end
