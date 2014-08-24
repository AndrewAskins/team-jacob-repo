//
//  PlaceTableViewCell.m
//  Wink
//
//  Created by Marvin on 8/23/14.
//  Copyright (c) 2014 Wink App. All rights reserved.
//

#import "PlaceTableViewCell.h"

@implementation PlaceTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPlace:(WNKPlace *)place
{
    _place = place;
    self.title.text = place.name;
    
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setRoundingMode: NSNumberFormatterRoundDown];

    NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:place.distance]];
    numberString = [numberString stringByAppendingString:@" miles"];
    self.distance.text = numberString;
    
    self.emojis.text = place.top_emoji;
    
    
    NSString *categories = @"";
    for(NSString *category in place.categories)
    {
        categories = [categories stringByAppendingString:category];
    }
    self.subtitle.text = categories;
    
    if (place.open_now) {
        self.open.text = @"Open";
    }
    else
    {
        self.open.text = @"";
    }
    // other stuff
}

@end
