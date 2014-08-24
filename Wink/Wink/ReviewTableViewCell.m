//
//  ReviewTableViewCell.m
//  Wink
//
//  Created by Marvin on 8/23/14.
//  Copyright (c) 2014 Wink App. All rights reserved.
//

#import "ReviewTableViewCell.h"

@implementation ReviewTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setReview:(WNKReview *)review
{
    _review = review;
    self.reviewLabel.text = review.review;
    self.username.text = review.username;
    self.date.text = review.review_time_pretty;
}

@end
