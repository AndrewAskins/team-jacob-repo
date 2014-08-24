//
//  WNKWinkApiClient.h
//  Wink
//
//  Created by Marvin on 8/23/14.
//  Copyright (c) 2014 Wink App. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFNetworking.h"

#define WinkApiBaseURL "http://jacob.rumblycloud.com"

@interface WNKWinkApiClient : AFHTTPClient

+(id)sharedClient;

@end
