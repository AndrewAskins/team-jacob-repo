//
//  SingleReviewTableViewController.h
//  Wink
//
//  Created by Marvin on 8/23/14.
//  Copyright (c) 2014 Wink App. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "WNKPlace.h"
#import "ReviewTableViewCell.h"
#import "AddReviewViewController.h"

@interface SingleReviewTableViewController : UITableViewController <AddReviewDelegate>

@property (nonatomic, strong) WNKPlace *place;

@property (nonatomic, strong) IBOutlet UITableViewCell *headerCell;
@property (nonatomic, strong) IBOutlet UITableViewCell *buttonCell;
@property (nonatomic, strong) IBOutlet UIImageView *headerImg;
@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UILabel *category;
@property (nonatomic, strong) IBOutlet UILabel *distance;

-(IBAction)addReview:(id)sender;

@end
