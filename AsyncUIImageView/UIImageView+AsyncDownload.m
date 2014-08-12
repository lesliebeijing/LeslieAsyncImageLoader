//
//  UIImageView+AsyncDownload.m
//  AsyncUIImageView
//
//  Created by Leslie.Fang on 14-8-11.
//  Copyright (c) 2014年 Enway. All rights reserved.
//

#import "UIImageView+AsyncDownload.h"

@implementation UIImageView (AsyncDownload)

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder{
    // 预设一个图片，可以为 nil
    self.image = placeholder;
    
    if (url) {
        // 异步下载图片
        LeslieAsyncImageDownloader *imageLoader = [LeslieAsyncImageDownloader sharedImageLoader];
        [imageLoader downloadImageWithURL:url
                                 complete:^(UIImage *image, NSError *error, NSURL *imageURL) {
                                     if (image) {
                                         // 下载完成后设置图片
                                         self.image = image;
                                     }else{
                                         NSLog(@"error when download:%@", error);
                                     }
                                 }];
    }
}
@end
