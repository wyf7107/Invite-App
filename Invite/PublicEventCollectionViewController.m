//
//  PublicEventCollectionViewController.m
//  Invite
//
//  Created by Yifan Wang on 15/12/18.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import "PublicEventCollectionViewController.h"
#import "CustomCollectionViewCell.h"
#import "ParseEventManager.h"
#import "CategoryTableViewController.h"


@interface PublicEventCollectionViewController ()

@end

@implementation PublicEventCollectionViewController



- (void)viewDidLoad {
 
    [super viewDidLoad];
    
    ParseUserManager *parseManager = [[ParseUserManager alloc]init];
    self.userManager = parseManager;
    
    
    
    
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [self.userManager setCurrentUser];
    
    if (self.userManager.currentUser) {
        
        NSLog(@"%@",self.userManager.currentUser.username);

    }else{
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 6;
}

- (CustomCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
   
    LayoutManager *layOutManager = [[LayoutManager alloc]init];
    self.layOutManager = layOutManager;
    
    NSMutableArray *configureArray = [self.layOutManager getPublicEventConfigureArray];
    NSDictionary *cateArray;
    
    for (int i = 0; i < indexPath.row + 1; i++) {
        cateArray = configureArray[i];
        cell.label.text = [NSString stringWithString:[cateArray objectForKey:@"label"]];
        cell.imageview.image = [UIImage imageNamed:[cateArray objectForKey:@"image"]];
        cell.layer.borderWidth = 2.5f;
        cell.layer.borderColor = [UIColor  colorWithRed:220 green:220 blue:220 alpha:1.0].CGColor;
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
  
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    self.indexPath = indexPath;
    
    [self performSegueWithIdentifier:@"showCategory" sender:self];
}


#pragma mark Segue Delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showLogin"]) {
        segue.destinationViewController.hidesBottomBarWhenPushed=YES;
    }
    
    if ([segue.identifier isEqualToString:@"showCategory"]) {
        CategoryTableViewController *vc = (CategoryTableViewController *)[segue destinationViewController];
        vc.titleStirng = [[self.layOutManager getPublicEventConfigureArray][self.indexPath.row] objectForKey:@"label"];
        
              
    }
}




#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
