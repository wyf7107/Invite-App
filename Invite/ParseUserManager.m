//
//  ParseUserManager.m
//  Invite
//
//  Created by Yifan Wang on 15/12/18.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import "ParseUserManager.h"

@implementation ParseUserManager

+(instancetype)userManager{
    static ParseUserManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ParseUserManager alloc] init];
    });
    manager.currentUser = [PFUser currentUser];

    return manager;
}


-(void)setCurrentUser{
    
    self.currentUser = [PFUser currentUser];
}


-(void)setFriendRelationArray:(SEL)action sender:(id)sender{
    [self setContactsDictionary];
    PFRelation *friendRelation = [[PFUser currentUser] relationForKey:@"friendRelation"];
    PFQuery *query = [friendRelation query];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@ %@",error,[error userInfo]);
        }else{
            NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:objects];
            
            for (PFUser *user in arr) {
                [self addUsernameToDictionary:user.username];
            }
            [sender performSelector:action];

        }
    }];
    
}







#pragma mark - helper methods






-(void)setContactsDictionary{
    
    NSMutableArray *nameArray =  [[NSMutableArray alloc]initWithCapacity:27];
    for (int i = 0; i <27; i++) {
        NSMutableArray *name = [[NSMutableArray alloc]init];
        [nameArray addObject:name];
    }
    
    self.contactDictionary = [[NSDictionary alloc] initWithObjects:nameArray forKeys:[UILocalizedIndexedCollation.currentCollation sectionIndexTitles]];
    
}


-(void)addUsernameToDictionary:(NSString *)username{
    
    
    NSString* firstLetter = [username substringToIndex:1];
  
    [firstLetter lowercaseString];
    
    if ([firstLetter  isEqual: @"a"]) {
        [self.contactDictionary[@"A"] addObject:username];
        
    }else if([firstLetter  isEqual: @"b"]){
        [self.contactDictionary[@"B"] addObject:username];
    }else if([firstLetter  isEqual: @"c"]){
        [self.contactDictionary[@"C"] addObject:username];
    }else if([firstLetter  isEqual: @"d"]){
        [self.contactDictionary[@"D"] addObject:username];
    }else if([firstLetter  isEqual: @"e"]){
        [self.contactDictionary[@"E"] addObject:username];
    }else if([firstLetter  isEqual: @"f"]){
        [self.contactDictionary[@"F"] addObject:username];
    }else if([firstLetter  isEqual: @"g"]){
        [self.contactDictionary[@"G"] addObject:username];
    }else if([firstLetter  isEqual: @"h"]){
        [self.contactDictionary[@"H"] addObject:username];
    }else if([firstLetter  isEqual: @"i"]){
        [self.contactDictionary[@"I"] addObject:username];
    }else if([firstLetter  isEqual: @"j"]){
        [self.contactDictionary[@"J"] addObject:username];
    }else if([firstLetter  isEqual: @"k"]){
        [self.contactDictionary[@"K"] addObject:username];
    }else if([firstLetter  isEqual: @"l"]){
        [self.contactDictionary[@"L"] addObject:username];
    }else if([firstLetter  isEqual: @"m"]){
        [self.contactDictionary[@"M"] addObject:username];
    }else if([firstLetter  isEqual: @"n"]){
        [self.contactDictionary[@"N"] addObject:username];
    }else if([firstLetter  isEqual: @"o"]){
        [self.contactDictionary[@"O"] addObject:username];
    }else if([firstLetter  isEqual: @"p"]){
        [self.contactDictionary[@"P"] addObject:username];
    }else if([firstLetter  isEqual: @"q"]){
        [self.contactDictionary[@"Q"] addObject:username];
    }else if([firstLetter  isEqual: @"r"]){
        [self.contactDictionary[@"R"] addObject:username];
    }else if([firstLetter  isEqual: @"s"]){
        [self.contactDictionary[@"S"] addObject:username];
    }else if([firstLetter  isEqual: @"t"]){
        [self.contactDictionary[@"T"] addObject:username];
    }else if([firstLetter  isEqual: @"u"]){
        [self.contactDictionary[@"U"] addObject:username];
    }else if([firstLetter  isEqual: @"v"]){
        [self.contactDictionary[@"V"] addObject:username];
    }else if([firstLetter  isEqual: @"w"]){
        [self.contactDictionary[@"W"] addObject:username];
    }else if([firstLetter  isEqual: @"x"]){
        [self.contactDictionary[@"X"] addObject:username];
    }else if([firstLetter  isEqual: @"y"]){
        [self.contactDictionary[@"Y"] addObject:username];
    }else if([firstLetter  isEqual: @"z"]){
        [self.contactDictionary[@"Z"] addObject:username];
    }else{
        [self.contactDictionary[@"#"] addObject:username];
    }
    

    
}








@end
