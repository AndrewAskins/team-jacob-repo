//
//  SingleReviewTableViewController.m
//  Wink
//
//  Created by Marvin on 8/23/14.
//  Copyright (c) 2014 Wink App. All rights reserved.
//

#import "SingleReviewTableViewController.h"

@interface SingleReviewTableViewController ()

@end

@implementation SingleReviewTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[SessionManager currentSession] requestDetailsForPlace:self.place];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdatePlace) name:@"RequestPlaceDetailsSuccess" object:nil];
    
    self.title = @"Wink ;)";
    
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)didUpdatePlace
{
//    for (WNKPlace *place in [[SessionManager currentSession] places]) {
//        if (place.place_id == self.place.place_id) {
//            self.place = place;
//        }
//    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AddReview delegate

-(void)reviewAdded:(WNKReview *)review
{
    [self.place.reviews addObject:review];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return 1;
    }
    return [self.place.reviews count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150.0;
    }
    else if (indexPath.section == 1) {
        return 60.0;
    }
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self.headerImg setImageWithURL:[NSURL URLWithString:self.place.imageURL] placeholderImage:[UIImage imageNamed:@"default@2x.png"]];
        self.name.text = self.place.name;
        self.category.text = [self.place.categories objectAtIndex:0];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setMaximumFractionDigits:1];
        [formatter setRoundingMode: NSNumberFormatterRoundDown];
        
        NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:self.place.distance]];
        numberString = [numberString stringByAppendingString:@" miles"];
        self.distance.text = numberString;
        
        return self.headerCell;
    }
    else if (indexPath.section == 1) {
        return self.buttonCell;
    }
    else
    {
    static NSString *cellIdentifier = @"ReviewTableViewCell";
        
    ReviewTableViewCell *cell = (ReviewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReviewTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
        
    // Configure the cell...
    WNKReview *currentReview = [self.place.reviews objectAtIndex:indexPath.row];
    cell.review = currentReview;
        
    return cell;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

#pragma mark - Table view delegate

//// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

-(IBAction)addReview:(id)sender
{
    AddReviewViewController *detailViewController = [[AddReviewViewController alloc] initWithNibName:@"AddReviewViewController" bundle:nil];
    detailViewController.place = self.place;
    detailViewController.delegate = self;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [navController.navigationBar setTranslucent:NO];
    navController.navigationBar.barTintColor = RGB(105, 210, 210);
    
    // Push the view controller.
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

@end
