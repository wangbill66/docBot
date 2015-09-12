//
//  Register.m
//  TabNavScrollSearch
//
//  Created by Bill on 8/9/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import "Register.h"


@interface Register () 

@end

NSString *f = @"sally";
NSString *l = @"johnson";
NSString *e = @"sallyjohnson@hotmail.com";
NSString *p = @"pancakeconster";
NSString *s = @"pedicare";

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

bool containsError;

@implementation Register {
    NSDictionary *reply;
    CGFloat animatedDistance;
}

@synthesize FirstName, LastName, email, password, confirmPassword, specialty;

- (void)viewDidLoad {
    [super viewDidLoad];
    //testing purposes. Remove afterwards.
//    [self registerDocbot:f with:l with:e with:p with:s];
    reply = [[NSDictionary alloc] init];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSString *) registerDocbot: (NSString *)firstNameR with: (NSString *)lastNameR with: (NSString *)emailR with: (NSString *)passwordR with: (NSString *) specialtyR {
    
    NSError *error;
    
    NSDictionary *registerInfo = @{
                    @"token" : @"lesalty",
                    @"email" : emailR,
                    @"password" : passwordR,
                    @"first_name" : firstNameR,
                    @"last_name" : lastNameR,
                    @"specialty" : specialtyR,
                    };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:registerInfo options:0                                                         error:&error];
    
    NSString *stringRep = [NSString stringWithFormat:@"%@", registerInfo];
    
    NSLog(@"This is json input: %@", stringRep);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:@"http://api.docbot.co/register"]];
    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if(connection) {
        NSLog(@"Connection Successful");
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSString *TokenReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSLog(@"Token Reply: %@", TokenReply);
            
            reply = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        }] resume];
        
        return @"gibeer";
        
    } else {
        NSLog(@"Connection could not be made");
    }
    
    return @"Gibberish";
    
}

- (IBAction)registerPressed:(id)sender {
    NSString *firstNameText = FirstName.text;
    NSString *lastNameText = LastName.text;
    NSString *emailText = email.text;
    NSString *passwordText = password.text;
    NSString *confirmPasswordText = confirmPassword.text;
    NSString *specialtyText = specialty.text;
    
    NSLog(@"Register Button pressed");
    
    if ([firstNameText length] == 0 || [lastNameText length] == 0 || [emailText length]== 0 || [passwordText length] == 0 || [confirmPasswordText length] == 0 || [specialtyText length] ==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Field" message:@"A field is missing" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    } else {
        if ([passwordText length] < 8) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password is not long enough!" message:nil delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
            [alert show];
            
        } else if ([passwordText isEqualToString:confirmPasswordText] == NO) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password and Confirmed Password are not equal" message:nil delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
            [alert show];
        
        } else {
            //check for duplicate usernames?
            
            NSLog(@"C1");
        
            [self registerDocbot:firstNameText with:lastNameText with:emailText with:passwordText with:specialtyText];
            NSLog(@"C2");
            [NSThread sleepForTimeInterval:3.0];
            NSLog(@"C3");

            if ([reply objectForKey:@"result"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register Successful!" message:nil delegate:self cancelButtonTitle:@"Next" otherButtonTitles:nil];
                [alert show];
                [self performSegueWithIdentifier:@"registerSuccessful" sender:nil];
            } else {
                
                if ([[reply objectForKey:@"error"] isEqualToString:@"Email already exists"]) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email already Exists!" message:nil delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:nil];
                    [alert show];
                    
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register Unsuccessful!" message:nil delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:nil];
                    [alert show];
                }

            }
            
            
        }
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
//
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    [self animateTextField:textField up:YES];
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [self animateTextField:textField up:NO];
//}
//
//-(void)animateTextField:(UITextField*)textField up:(BOOL)up
//{
//    const int movementDistance = -50; // tweak as needed
//    const float movementDuration = 0.3f; // tweak as needed
//    
//    int movement = (up ? movementDistance : -movementDistance);
//    
//    [UIView beginAnimations: @"animateTextField" context: nil];
//    [UIView setAnimationBeginsFromCurrentState: YES];
//    [UIView setAnimationDuration: movementDuration];
//    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
//    [UIView commitAnimations];
//}


//=============
//
//-(BOOL) textFieldShouldReturn:(UITextField *)textField{
//    
//    [textField resignFirstResponder];
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.25];
//    self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
//    [UIView commitAnimations];
//    return YES;
//}
//
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.25];
//    self.view.frame = CGRectMake(0,-70,self.view.frame.size.width,self.view.frame.size.height);
//    [UIView commitAnimations];
//    
//}

//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y);
//    [self.scrollView setContentOffset:scrollPoint animated:YES];
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    [scrollView setContentOffset:CGPointZero animated:YES];
//}
//==========

//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//
//    [self animateTextField:textField up:YES];
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [self animateTextField:textField up:NO];
//}
//
//-(void)animateTextField:(UITextField*)textField up:(BOOL)up
//{
//    const int movementDistance = -200; // tweak as needed
//    const float movementDuration = 0.3f; // tweak as needed
//    
//    int movement = (up ? movementDistance : -movementDistance);
//    
//    [UIView beginAnimations: @"animateTextField" context: nil];
//    [UIView setAnimationBeginsFromCurrentState: YES];
//    [UIView setAnimationDuration: movementDuration];
//    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
//    [UIView commitAnimations];
//}



@end
