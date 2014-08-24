//
//  WNKPlace.h
//  Wink
//
//  Created by Marvin on 8/23/14.
//  Copyright (c) 2014 Wink App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface WNKPlace : NSObject

@property (nonatomic, assign) double distance;
@property (nonatomic, assign) BOOL open_now;
@property (nonatomic, assign) CLLocationCoordinate2D *location;

@property (nonatomic, strong) NSString *place_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *vicinity;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSString *top_emoji;
@property (nonatomic, strong) NSMutableArray *reviews;

@end
