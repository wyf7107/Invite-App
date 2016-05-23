//
//  EditMyEventTableViewController.h
//  Invite
//
//  Created by Yifan Wang on 16/1/5.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ParseEventManager.h"
#import "SCLAlertView.h"

@interface EditMyEventTableViewController : UITableViewController
@property (nonatomic,strong) ParseEventManager *eventManager;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@property (nonatomic,strong) PFObject *selectedEvent;

@end
