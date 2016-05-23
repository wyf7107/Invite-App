//
//  ContactsTableViewController.h
//  Invite
//
//  Created by Yifan Wang on 16/1/7.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUserManager.h"
#import <Parse/Parse.h>

@interface ContactsTableViewController : UITableViewController
@property (nonatomic,strong) NSArray *indexTitles;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@property (nonatomic,strong) ParseUserManager *userManager;


@end
