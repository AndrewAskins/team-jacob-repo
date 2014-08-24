//
//  SessionManager.m
//  Wink
//
//  Created by Marvin on 8/23/14.
//  Copyright (c) 2014 Wink App. All rights reserved.
//

#import "SessionManager.h"

static SessionManager *currentSession;

@implementation SessionManager

+(id)currentSession
{
    if (!currentSession)
    {
        currentSession = [[self alloc] init];
    }
    return currentSession;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        self.places = [NSMutableArray array];
    }
    return self;
}

-(void)requestNearbyPlaces
{
    CLLocationDegrees latitude = 32.78;
    NSNumber *lat = [NSNumber numberWithDouble:latitude];
    
    CLLocationDegrees longitude = -79.93;
    NSNumber *lng = [NSNumber numberWithDouble:longitude];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:lat forKey:@"lat"];
    [params setObject:lng forKey:@"lng"];

    [[WNKWinkApiClient sharedClient] getPath:@"search" parameters:params success:^(AFHTTPRequestOperation *operation , id response) {
        
        for (id item in response) {
            WNKPlace *place = [[WNKPlace alloc] init];
            place.place_id = item[@"place_id"];
            place.name = item[@"name"];
            place.categories = item[@"categories"];
            place.top_emoji = @"";
            for(id emoji in item[@"top_emoji"])
            {
                NSString *singleEmoji = [ZWEmoji emojify:emoji];
                
                place.top_emoji = [place.top_emoji stringByAppendingString:singleEmoji];
                place.top_emoji = [place.top_emoji stringByAppendingString:@" "];
            }
            place.categories = [NSMutableArray array];
            int i = 0;
            for(id category in item[@"categories"])
            {
                if (i == 0) {
                    [place.categories addObject:category];
                }
                i++;
            }
            NSString *distance = item[@"distance"];
            place.distance = [distance doubleValue];
            place.imageURL = item[@"img_url"];
            [self.places addObject:place];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RequestPlacesSuccess" object:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];
}

-(void)requestDetailsForPlace:(WNKPlace *)place
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:place.place_id forKey:@"place_id"];
    
    [[WNKWinkApiClient sharedClient] getPath:@"details" parameters:params success:^(AFHTTPRequestOperation *operation , id response) {
        NSLog(@"JSON! %@", response);
        
        place.phone = response[@"phone"];
        place.vicinity = response[@"vicinity"];
        NSString *open = response[@"open_now"];
        place.open_now = [open boolValue];
        
        for (id review in response[@"reviews"]) {
            WNKReview *newReview = [[WNKReview alloc] init];
            newReview.review_id = review[@"review_id"];
            newReview.place_id = review[@"place_id"];
            newReview.username = review[@"reviewer"];
            newReview.review_time_pretty = review[@"review_time_pretty"];
            NSString *content = @" ";
            for (id item in review[@"content"]) {
                content = [content stringByAppendingString:[ZWEmoji emojify:item]];
                content = [content stringByAppendingString:@" "];
            }
            newReview.review = content;
            
            [place.reviews addObject:newReview];
        }
        
//        for (WNKPlace *oldPlace in self.places) {
//            if (oldPlace.place_id == place.place_id) {
//                __strong oldPlace = place;
//            }
//        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RequestPlaceDetailsSuccess" object:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];
}

-(void)postReviewForPlace:(WNKPlace *)place andReview:(WNKReview *)review
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:place.place_id forKey:@"place_id"];
    [params setObject:review.username forKey:@"reviewer"];
    
    NSString *reviewText = review.review;
    NSMutableArray *emoji = [self convertStringToArray:reviewText];
    for (int i = 0; i < [emoji count]; i++) {
        NSString *anEmoji = [emoji objectAtIndex:i];
        anEmoji = [ZWEmoji unemojify:anEmoji];
        
        [emoji removeObjectAtIndex:i];
        [emoji insertObject:anEmoji atIndex:i];
    }
    [params setObject:emoji forKey:@"emoji"];
    
    [[WNKWinkApiClient sharedClient] postPath:@"reviews" parameters:params success:
    ^(AFHTTPRequestOperation *operation, id response){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PostReviewSuccess" object:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"error");
    }];
}

- (NSMutableArray *)convertStringToArray:(NSString *)string {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSUInteger i = 0;
    while (i < string.length) {
        NSRange range = [string rangeOfComposedCharacterSequenceAtIndex:i];
        NSString *chStr = [string substringWithRange:range];
        [arr addObject:chStr];
        i += range.length;
    }
    
    return arr;
}

@end
