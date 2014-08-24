//
//  AddReviewViewController.h
//  Wink
//
//  Created by Marvin on 8/23/14.
//  Copyright (c) 2014 Wink App. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNKPlace.h"
#import "WNKReview.h"
#import "AGEmojiKeyBoardView.h"
#import "SessionManager.h"

@protocol AddReviewDelegate <NSObject>

-(void)reviewAdded:(WNKReview *)review;

@end

@interface AddReviewViewController : UIViewController <AGEmojiKeyboardViewDelegate, AGEmojiKeyboardViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) id delegate;

@property (nonatomic, strong) WNKPlace *place;
@property (nonatomic, strong) WNKReview *review;

@property (nonatomic, strong) IBOutlet UITextField *usernameField;
@property (nonatomic, strong) IBOutlet UITextField *reviewField;

@end
