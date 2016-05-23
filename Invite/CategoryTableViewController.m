//
//  CategoryTableViewController.m
//  Invite
//
//  Created by Yifan Wang on 15/12/21.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "CategoryTableViewCell.h"
#import "DetailEventTableViewController.h"
#import "MSCellAccessory.h"
#import "SCLAlertView.h"

@interface CategoryTableViewController ()

@end

@implementation CategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.eventManager  =[[ParseEventManager alloc]init];
    
    self.userManager = [[ParseUserManager alloc] init];
    

    //[self.eventManager createNewEventWithCategory:@"Movie" Name:@"Fun Movie" Time:@"11.30" Place:@"Home" Description:@"funny" Starter:[PFUser currentUser][@"username"] Attenders:[PFUser currentUser][@"username"]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
 
    
    self.title = self.titleStirng;
    if ([self.eventManager.categoryQueryArray count] == 0) {
        [self showActivityView];
        
        [self.eventManager getPublicQueryWithCategoryName:self.titleStirng withAction:@selector(hideActivityView) fromObject:self];
        
        
    }
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    if (self.eventManager.categoryQueryArray) {
        return [self.eventManager.categoryQueryArray count];
    }else{
        return 0;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (CategoryTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.eventName.text = self.eventManager.categoryQueryArray[indexPath.section][@"Name"];
    cell.eventStarter.text = [NSString stringWithFormat:@"created by %@",self.eventManager.categoryQueryArray[0][@"Starter"]];
    cell.eventTime.text = self.eventManager.categoryQueryArray[indexPath.section][@"Time"];
     cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DETAIL_DISCLOSURE colors:@[[UIColor colorWithRed:245/255.0 green:142/255.0 blue:4/255.0 alpha:1.0], [UIColor colorWithWhite:0.7 alpha:1.0]]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *eventTime = [formatter dateFromString:cell.eventTime.text];
   
    
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
   
    NSDate *currentDate = [formatter dateFromString:currentTime];


    if ([eventTime isEarlierThan:currentDate]) {
        cell.layer.borderWidth = 2.0;
        cell.layer.borderColor = [UIColor redColor].CGColor;
        cell.eventTime.textColor = [UIColor redColor];
        cell.userInteractionEnabled = NO;
    }else{
        
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.indexPath = indexPath;
    [self performSegueWithIdentifier:@"showEventDetail" sender:self];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.indexPath = indexPath;
    [self performSegueWithIdentifier:@"showEventDetail" sender:self];
}


#pragma mark Segue Delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showEventDetail"]) {
        DetailEventTableViewController *vc = (DetailEventTableViewController *)segue.destinationViewController;
        vc.detailInformationArray = self.eventManager.categoryQueryArray[self.indexPath.section];
        PFObject *object = self.eventManager.categoryQueryArray[self.indexPath.section];
        vc.chosenEventId = object.objectId;
               
    }
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
    if ([self.eventManager.categoryQueryArray count] == 0) {
        SCLAlertView *alert = [[SCLAlertView alloc]init];
        [alert showError:self title:@"Sorry!"
                subTitle:@"No Public Event Found!"
        closeButtonTitle:@"OK" duration:0.0f];
    }else{
        [self.tableView reloadData];
    }
    
    [self.activityView stopAnimating];
}


#pragma mark Helper Methods


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
