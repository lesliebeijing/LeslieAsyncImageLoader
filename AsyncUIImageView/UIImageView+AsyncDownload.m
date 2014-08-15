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
    // 给  ImageView 设置 tag, 指向当前 url
    self.tag = [url absoluteString];
    
    // 预设一个图片，可以为 nil
    // 主要是为了清除由于复用以前可能存在的图片
    self.image = placeholder;
    
    if (url) {
        // 异步下载图片
        LeslieAsyncImageDownloader *imageLoader = [LeslieAsyncImageDownloader sharedImageLoader];
        [imageLoader downloadImageWithURL:url
                                 complete:^(UIImage *image, NSError *error, NSURL *imageURL) {
                                     // 通过 tag 保证图片被正确的设置
                                     if (image && [self.tag isEqualToString:[imageURL absoluteString]]) {
                                         self.image = image;
                                     }else{
                                         NSLog(@"error when download:%@", error);
                                     }
                                 }];
    }
}

@end
