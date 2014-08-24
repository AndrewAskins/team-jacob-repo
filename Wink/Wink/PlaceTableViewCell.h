//
//  PlaceTableViewCell.h
//  Wink
//
//  Created by Marvin on 8/23/14.
//  Copyright (c) 2014 Wink App. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNKPlace.h"

@interface PlaceTableViewCell : UITableViewCell

@property (nonatomic, strong) WNKPlace *place;
@property (nonatomic, strong) IBOutlet UILabel *emojis;
@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) IBOutlet UILabel *subtitle;
@property (nonatomic, strong) IBOutlet UILabel *distance;
@property (nonatomic, strong) IBOutlet UILabel *open;

@end
