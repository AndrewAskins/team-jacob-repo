//
//  AppDelegate.h
//  Wink
//
//  Created by Marvin on 8/23/14.
//  Copyright (c) 2014 Wink App. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewTableViewController.h"
#import "SessionManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *rootViewController;
@property (strong, nonatomic) UINavigationController *navController;

@end
