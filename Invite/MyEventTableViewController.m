//
//  MyEventTableViewController.m
//  Invite
//
//  Created by Yifan Wang on 16/1/3.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import "MyEventTableViewController.h"
#import <Parse/Parse.h>
#import "CategoryTableViewCell.h"
#import "SCLAlertView.h"
#import "MSCellAccessory.h"
#import "DateTools.h"
#import "DetailEventTableViewController.h"
#import "EventDetailTableViewController.h"
@interface MyEventTableViewController ()

@end

@implementation MyEventTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    if (!self.eventManager) {
        ParseEventManager *eventManager = [[ParseEventManager alloc]init];
        self.eventManager = eventManager;
    }

}


-(void)viewWillAppear:(BOOL)animated{
    
    
        [self showActivityView];
        
        [self.eventManager getMyQueryArray:[PFUser currentUser].username withAction:@selector(hideActivityView) fromObject:self];
        
   
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.eventManager.myPublicQueryArray count];
    }else{
        return [self.eventManager.myPrivateQueryArray count];
    }
   
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 104;
}

- (CategoryTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *eventName;
    NSString *eventStarter;
    NSString *eventTime;
    MSCellAccessory *accessoryView =[MSCellAccessory accessoryWithType:FLAT_DETAIL_DISCLOSURE colors:@[[UIColor colorWithRed:245/255.0 green:142/255.0 blue:4/255.0 alpha:1.0], [UIColor colorWithWhite:0.7 alpha:1.0]]];
    
    if (indexPath.section == 0) {
        eventName = self.eventManager.myPublicQueryArray[indexPath.row][@"Name"];
        eventStarter = [NSString stringWithFormat:@"created by %@",self.eventManager.myPublicQueryArray[0][@"Starter"]];
        eventTime = self.eventManager.myPublicQueryArray[indexPath.row][@"Time"];
        
    }
    
    if (indexPath.section == 1) {
        eventName = self.eventManager.myPrivateQueryArray[indexPath.row][@"Name"];
        eventStarter = [NSString stringWithFormat:@"created by %@",self.eventManager.myPrivateQueryArray[0][@"Starter"]];
        eventTime = self.eventManager.myPrivateQueryArray[indexPath.row][@"Time"];
 
    }
    
    CategoryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.eventName.text = eventName;
    cell.eventStarter.text = eventStarter;
    cell.eventTime.text = eventTime;
    cell.accessoryView = accessoryView;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *eventDate = [formatter dateFromString:eventTime];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [formatter dateFromString:currentTime];

    if ([eventDate isEarlierThan:currentDate]) {
        cell.layer.borderWidth = 2.0;
        cell.layer.borderColor = [UIColor redColor].CGColor;
        cell.eventTime.textColor = [UIColor redColor];
        cell.userInteractionEnabled = NO;
    }else{
        
    }
    

    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Public";
    }else{
        return @"Private";
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.indexPath = indexPath;
    [self performSegueWithIdentifier:@"showDetail" sender:self];
    //DetailEventTableViewController *vc = [[DetailEventTableViewController alloc]init];
    //[self presentViewController:vc animated:YES completion:nil];
}


-(void) showActivityView {
    if (self.activityView==nil) {
        self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
        [self.tableView addSubview:self.activityView];
        self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        self.activityView.color = [UIColor redColor];
        self.activityView.hidesWhenStopped = YES;
        // additional setup...
        // self.activityView.color = [UIColor redColor];
    }
    // Center
    CGFloat x = UIScreen.mainScreen.applicationFrame.size.width/2;
    CGFloat y = UIScreen.mainScreen.applicationFrame.size.height/2;
    // Offset. If tableView has been scrolled
    CGFloat yOffset = self.tableView.contentOffset.y;
    self.activityView.frame = CGRectMake(x, y + yOffset, 0, 0);
    
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
}


- (void) hideActivityView {
    
    if ([self.eventManager.myPublicQueryArray count]==0 && [self.eventManager.myPrivateQueryArray count] == 0) {
        SCLAlertView *alert = [[SCLAlertView alloc]init];
        [alert showError:self title:@"Sorry!"
                subTitle:@"You haven't joined any events!"
        closeButtonTitle:@"OK" duration:0.0f];
    }else{
        
        [self.tableView reloadData];
    }
    
    
    
    [self.activityView stopAnimating];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        EventDetailTableViewController *vc = (EventDetailTableViewController *)segue.destinationViewController;
        if (self.indexPath.section == 0) {
            vc.detailInformationArray = self.eventManager.myPublicQueryArray[self.indexPath.row];
            PFObject *object = self.eventManager.myPublicQueryArray[self.indexPath.row];
            vc.chosenEventId = object.objectId;
        }else{
            vc.detailInformationArray = self.eventManager.myPrivateQueryArray[self.indexPath.row];
            PFObject *object = self.eventManager.myPrivateQueryArray[self.indexPath.row];
            vc.chosenEventId = object.objectId;

        }
       
        
    }
}



@end
