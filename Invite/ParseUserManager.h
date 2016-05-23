//
//  ParseUserManager.h
//  Invite
//
//  Created by Yifan Wang on 15/12/18.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ParseUserManager : NSObject
@property (nonatomic,strong) PFUser *currentUser;
@property (nonatomic,strong) NSDictionary *contactDictionary;

+(instancetype)userManager;

-(void)setCurrentUser;

-(void)setFriendRelationArray:(SEL)action sender:(id)sender;




@end
