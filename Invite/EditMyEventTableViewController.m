//
//  EditMyEventTableViewController.m
//  Invite
//
//  Created by Yifan Wang on 16/1/5.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import "EditMyEventTableViewController.h"
#import "MSCellAccessory/MSCellAccessory.h"

@interface EditMyEventTableViewController ()

@end

@implementation EditMyEventTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.eventManager) {
        self.eventManager = [[ParseEventManager alloc]init];
    }}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self showActivityView];
    [self.eventManager getMyQueryArray:[PFUser currentUser].username withAction:@selector(hideActivityView) fromObject:self];
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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Public";
    }else{
        return @"Private";
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
    
    NSString *eventName;
    NSString *eventTime;
    
    if (indexPath.section == 0) {
        eventName = self.eventManager.myPublicQueryArray[indexPath.row][@"Name"];
        eventTime = self.eventManager.myPublicQueryArray[indexPath.row][@"Time"];
    }else{
        eventName = self.eventManager.myPrivateQueryArray[indexPath.row][@"Name"];
        eventTime = self.eventManager.myPrivateQueryArray[indexPath.row][@"Time"];
    }
    
    
    cell.textLabel.text = eventName;
    cell.detailTextLabel.text = eventTime;
    cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_CHECKMARK color:[UIColor orangeColor]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Quit This Event?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *quitEvent = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (indexPath.section == 0) {
            self.selectedEvent = self.eventManager.myPublicQueryArray[indexPath.row];
            
        }else{
            self.selectedEvent = self.eventManager.myPrivateQueryArray[indexPath.row];
            
        }
        
        [self.eventManager deleteAttender:[PFUser currentUser].username withEventd:self.selectedEvent.objectId sender:self cell:cell];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:quitEvent];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


#pragma mark - helper methods
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
    
    if ([self.eventManager.myPublicQueryArray count]== 0 && [self.eventManager.myPrivateQueryArray count] == 0) {
        SCLAlertView *alert = [[SCLAlertView alloc]init];
        [alert showError:self title:@"Sorry!"
                subTitle:@"You haven't joined any events!"
        closeButtonTitle:@"OK" duration:0.0f];
    }else{
        
        [self.tableView reloadData];
    }
    
    
    
    [self.activityView stopAnimating];
}


@end
