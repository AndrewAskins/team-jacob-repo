//
//  SessionManager.h
//  Wink
//
//  Created by Marvin on 8/23/14.
//  Copyright (c) 2014 Wink App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "WNKWinkApiClient.h"
#import "WNKPlace.h"
#import "WNKReview.h"
#import "ZWEmoji.h"

#import "AFNetworking.h"

#define WinkAPIClient [WNKWinkApiClient sharedClient];

@interface SessionManager : NSObject

@property (nonatomic, strong) NSMutableArray *places;

+(id)currentSession;
-(void)requestNearbyPlaces;
-(void)postReviewForPlace:(WNKPlace *)place andReview:(WNKReview *)review;
-(void)requestDetailsForPlace:(WNKPlace *)place;

@end
