//
//  ReviewTableViewController.h
//  Wink
//
//  Created by Marvin on 8/23/14.
//  Copyright (c) 2014 Wink App. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleReviewTableViewController.h"
#import "SessionManager.h"
#import "PlaceTableViewCell.h"

#define CurrentSession [SessionManager currentSession]

@interface ReviewTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *places;

@end
