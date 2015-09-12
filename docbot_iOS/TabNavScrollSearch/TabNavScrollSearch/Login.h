//
//  Login.h
//  TabNavScrollSearch
//
//  Created by Bill on 8/15/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;


- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)backgroundTapped:(id)sender;


- (NSString *) authenticateDocbot: (NSString *)token with: (NSString *)emailA with: (NSString *)passwordA with: (NSString *)reg_idR;
@end
