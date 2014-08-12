//
//  LeslieMainTableViewController.h
//  AsyncUIImageView
//
//  Created by Leslie.Fang on 14-8-11.
//  Copyright (c) 2014年 Enway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeslieMyTableViewCell.h"
#import "UIImageView+AsyncDownload.h"

@interface LeslieMainTableViewController : UITableViewController{
    @private
    NSArray *data;
    NSCache *memCache;
}

@end
