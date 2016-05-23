//
//  CategoryTableViewController.h
//  Invite
//
//  Created by Yifan Wang on 15/12/21.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ParseEventManager.h"
#import "ParseUserManager.h"
#import "DateTools.h"

@interface CategoryTableViewController : UITableViewController
@property (nonatomic,strong) NSString *titleStirng;
@property (nonatomic,strong) ParseEventManager *eventManager;
@property (nonatomic,strong) ParseUserManager *userManager;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@property (nonatomic,strong) NSIndexPath *indexPath;


@end
