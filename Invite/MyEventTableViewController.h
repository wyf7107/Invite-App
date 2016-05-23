//
//  MyEventTableViewController.h
//  Invite
//
//  Created by Yifan Wang on 16/1/3.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseEventManager.h"


@interface MyEventTableViewController : UITableViewController
@property (nonatomic,strong) ParseEventManager *eventManager;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@property (nonatomic,strong) NSIndexPath *indexPath;

@end
