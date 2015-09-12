//
//  Allscripts.m
//  TabNavScrollSearch
//
//  Created by Bill on 8/15/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import "Allscripts.h"
#import "Singleton.h"
#import "KeychainItemWrapper.h"
#import "AppDelegate.h"

@interface Allscripts ()

@end

//=========TOKEN fields
//NSString *svcUsername = @"DocBo-511f-docbotdemo-test";
//NSString *svcPassword = @"D!4B!tDecBct-d7M!t1st@pp4d4Dc";
//NSString *url = @"http://twlatestga.unitysandbox.com";
////========= MAGIC ACTION fields
//NSString *ehrUsername = @"jmedici";
//NSString *ehrPassword = @"";
//NSString *appname = @"DocBot.docbot-demo.TestApp";
////=============TOKEN
//NSString *Token = @"";

@implementation Allscripts {
    UIActivityIndicatorView *indicator;
    NSString *allscriptsPageUsername;
}

@synthesize username, password;

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSString *) processRequest {
//    indicator = [[UIActivityIndicatorView alloc] init];
    
    indicator.center = self.view.center;
    indicator.color = [UIColor blackColor];
    [self.view addSubview:indicator];
    [indicator startAnimating];
    
    NSString *usernameText = username.text;
    NSString *passwordText = password.text;
    Singleton *shared = [Singleton sharedManager];
    
    NSLog(@"Button Rpessed");
    
    [shared authenticate:shared.svcUsername with:shared.svcPassword];
    [NSThread sleepForTimeInterval:1.0];
    
    [self.indicator startAnimating];
    
    if ([usernameText length] == 0 || [passwordText length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Field" message:@"A field is missing" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    } else {
        
        [shared magicAction:@"GetUserAuthentication" with:shared.appname with:@"jmedici" with:@"" with:shared.Token with1:@"password01" with2:@"" with3:@"" with4:@"" with5:@"" with6:@"" with:@""];
        
        [NSThread sleepForTimeInterval:1.0];
        
        NSError *jsonError;
        //        NSLog(@"ddsd%@", shared.dataReply);
        
        NSMutableArray *reply = [NSJSONSerialization JSONObjectWithData:shared.dataReply options:0 error:&jsonError];
        
        //        NSLog(@"REPLY: %@", reply);
        
        NSString *validUser = @"";
        
        //        NSLog(@"allscripts Reply %@", reply);
        
        for (NSDictionary *dick in reply) {
            
            NSArray *subArray = [dick objectForKey:@"getuserauthenticationinfo"];
            
            for (NSDictionary *subsubDick in subArray) {
                validUser = subsubDick[@"ValidUser"];
            }
        }
        
        NSLog(@"ValidUser %@", validUser);
        
        [NSThread sleepForTimeInterval:0.5];
        allscriptsPageUsername = usernameText;
        
        return validUser;
        
//        if (validUser) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successful Login!" message:nil delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
//            [alert show];
//            [self performSegueWithIdentifier:@"allscriptsSuccessful" sender:nil];
//        } else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Incorrect Username or Password" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
//            [alert show];
//        }

        
    }
    return @"0_0";
}

- (IBAction)authenticateButtonPressed:(id)sender {
    
    
//    indicator = [[UIActivityIndicatorView alloc] init];
//    
    self.indicator.center = self.view.center;
    self.indicator.color = [UIColor blackColor];
    [self.view addSubview:indicator];
    [self.indicator startAnimating];
    
    __block NSString *result = @"Change this mofo!";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        result = [self processRequest];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"%@", result);
            if ([result  isEqual: @"YES"]) {
                
                AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                delegate.allscriptsUsername = allscriptsPageUsername;
                
                KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"AllscriptsData" accessGroup:nil];
                
                [keychainItem setObject:allscriptsPageUsername forKey:(__bridge id)kSecAttrAccount];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successful Login!" message:nil delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
                [alert show];
                [self performSegueWithIdentifier:@"allscriptsSuccessful" sender:nil];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Username or Password" message:nil delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
                [alert show];
            }
            [self.indicator stopAnimating];
        });
    });
}

- (UIActivityIndicatorView *)indicator {
    if (!indicator) {
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return indicator;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [seg
 ue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

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
//
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

//===============

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.25];
//    self.view.frame = CGRectMake(0,-10,320,480);
//    [UIView commitAnimations];
//    
//}
@end
