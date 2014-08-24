//
//  WNKPlace.m
//  Wink
//
//  Created by Marvin on 8/23/14.
//  Copyright (c) 2014 Wink App. All rights reserved.
//

#import "WNKPlace.h"

@implementation WNKPlace

-(id)init
{
    self = [super init];
    if (self)
    {
        self.reviews = [NSMutableArray array];
    }
    return self;
}

@end
