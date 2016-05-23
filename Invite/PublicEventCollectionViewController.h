//
//  PublicEventCollectionViewController.h
//  Invite
//
//  Created by Yifan Wang on 15/12/18.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUserManager.h"
#import "LayoutManager.h"
@interface PublicEventCollectionViewController : UICollectionViewController
@property (nonatomic,strong) ParseUserManager *userManager;
@property (nonatomic,strong) LayoutManager *layOutManager;
@property (nonatomic,strong) NSIndexPath *indexPath;



@end
