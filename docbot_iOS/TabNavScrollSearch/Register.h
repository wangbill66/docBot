//
//  Register.h
//  TabNavScrollSearch
//
//  Created by Bill on 8/9/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Register : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *FirstName;

@property (weak, nonatomic) IBOutlet UITextField *LastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
@property (weak, nonatomic) IBOutlet UITextField *specialty;

- (IBAction)registerPressed:(id)sender;

@end
