//
//  WNKWinkApiClient.m
//  Wink
//
//  Created by Marvin on 8/23/14.
//  Copyright (c) 2014 Wink App. All rights reserved.
//

#import "WNKWinkApiClient.h"

static WNKWinkApiClient *sharedClient;

@implementation WNKWinkApiClient

+(id)sharedClient
{
    if (!sharedClient) {
        NSURL *baseURL = [NSURL URLWithString:@WinkApiBaseURL];
        sharedClient = [WNKWinkApiClient clientWithBaseURL:baseURL];
        sharedClient.parameterEncoding = AFJSONParameterEncoding;
        [sharedClient setDefaultHeader:@"Accept" value:@"application/json"];
        [sharedClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
    return sharedClient;
}

@end
