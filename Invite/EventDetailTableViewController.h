//
//  EventDetailTableViewController.h
//  Invite
//
//  Created by Yifan Wang on 16/1/5.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutManager.h"

@interface EventDetailTableViewController : UITableViewController
@property (nonatomic,strong) LayoutManager *layoutManager;
@property (nonatomic,strong) NSArray *configureArray;
@property (nonatomic,strong) NSDictionary *detailInformationArray;
@property (nonatomic,strong) NSString *chosenEventId;


@end
