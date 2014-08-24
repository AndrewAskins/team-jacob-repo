//
//  ReviewTableViewCell.h
//  Wink
//
//  Created by Marvin on 8/23/14.
//  Copyright (c) 2014 Wink App. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNKReview.h"

@interface ReviewTableViewCell : UITableViewCell

@property (nonatomic, strong) WNKReview *review;

@property (nonatomic, strong) IBOutlet UILabel *reviewLabel;
@property (nonatomic, strong) IBOutlet UILabel *username;
@property (nonatomic, strong) IBOutlet UILabel *date;

@end
