//
//  Allscripts.h
//  TabNavScrollSearch
//
//  Created by Bill on 8/15/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Allscripts : UIViewController <UITextFieldDelegate>

extern NSString *appname;

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)authenticateButtonPressed:(id)sender;

@end
