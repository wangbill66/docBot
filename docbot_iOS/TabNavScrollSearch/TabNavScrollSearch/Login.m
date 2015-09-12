//
//  Login.m
//  TabNavScrollSearch
//
//  Created by Bill on 8/15/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import "Login.h"
#import "KeychainItemWrapper.h"
#import "AppDelegate.h"

@interface Login()

@end

@implementation Login {
    UIActivityIndicatorView *indicator;
}

@synthesize username, password;

bool containsError;
int containsErrorInt;
NSDictionary *reply;
id reg_id;


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"DocBotLoginData" accessGroup:nil];
    KeychainItemWrapper *keychainItem2 = [[KeychainItemWrapper alloc] initWithIdentifier:@"AllscriptsData" accessGroup:nil];
    
    NSString *username = [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
    
    NSLog(@"keychain username is: %@", [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)]);
    
    NSLog(@"allscripts username is: %@", [keychainItem2 objectForKey:(__bridge id)(kSecAttrAccount)]);

    
    
}

- (NSString *) authenticateDocbot: (NSString *)token with: (NSString *)emailA with: (NSString *)passwordA with: (NSString *)reg_idR {
    
    NSError *error;
    
                ///Eddit this part1!!!!
    NSDictionary *loginInfo = @{
                                   @"token" : @"lesalty",
                                   @"email" : emailA,
                                   @"passw" : passwordA,
                                   @"reg_id" : @"Filler"
                                   };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:loginInfo options:0                                                         error:&error];
    
    NSString *stringRep = [NSString stringWithFormat:@"%@", loginInfo];
    
    NSLog(@"This is json input: %@", stringRep);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:@"http://api.docbot.co/auth"]];
    
    [request setHTTPMethod:@"POST"];
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if(connection) {
        NSLog(@"Connection Successful");
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
        NSError *jsonError;
        reply = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        
            
        NSString *TokenReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"Token Reply: %@", TokenReply);
            
        }] resume];
        
        return reply;
        
    } else {
        NSLog(@"Connection could not be made");
    }
    
    return @"Gibberish";
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)loginButtonPressed:(id)sender {

    NSString *usernameText = username.text;
    NSString *passwordText = password.text;
    
    
    NSLog(@"Login Button pressed");
    
    if ([usernameText length] == 0 || [passwordText length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Field" message:@"A field is missing" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    } else {
        
        //Remove this part
        //        [self authenticateDocbot:nil with:@"oceansapart13@yahoo.com" with:@"password" with:nil];
        [self authenticateDocbot:nil with:usernameText      with:passwordText with:nil];
        
        [NSThread sleepForTimeInterval:2.0];
        
        while ([reply count] == 0) {
        }
        
        containsError = [reply objectForKey:@"error"];
        
        if (containsError == 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Username or Password" message:nil delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
            [alert show];
        } else {
        
            
        reg_id = [reply objectForKey:@"id"];
        NSLog(@"PATIENT ID IS %@", reg_id);
        
        
        KeychainItemWrapper *keychain =
        [[KeychainItemWrapper alloc] initWithIdentifier:@"DocBotLoginData" accessGroup:nil];
        [keychain setObject:usernameText forKey:(__bridge id)kSecAttrAccount];
        [keychain setObject:passwordText forKey:(__bridge id)kSecValueData];
        [keychain setObject:@"jmedici" forKey:(__bridge id)kSecAttrComment];

        NSLog(@"docBot username stored in keychain is: %@", [keychain objectForKey:(__bridge id)(kSecAttrAccount)]);
        
//        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//        delegate.linkKeychain = keychain;
        
        [self performSegueWithIdentifier:@"loginSuccessful" sender:nil];
        }
    }
    
//=============
////    NSString *usernameText = username.text;
////    NSString *passwordText = password.text;
////    
//    self.indicator.center = self.view.center;
//    self.indicator.color = [UIColor blackColor];
//    [self.view addSubview:indicator];
//    [self.indicator startAnimating];
//    NSLog(@"Button presed");
//    
////    __block NSString *result = @"Change this mofo!";
//    
////    if ([usernameText length] == 0 || [passwordText length] == 0) {
////        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Field" message:@"A field is missing" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
////        [alert show];
//    
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self processRequest];
//        
//        dispatch_sync(dispatch_get_main_queue(), ^{
//          NSLog(@"%@", containsError);
////            while (containsError == nil) {
////                
////            }
//    
//            containsError = [reply objectForKey:@"error"];
//            
//            NSLog(@"reply%@", reply);
//            while (reply == nil) {
//                
//            }
//            if (containsError == 1) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Username or Password" message:nil delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
//                [alert show];
//            } else {
//                reg_id = [reply objectForKey:@"id"];
//                NSLog(@"PATIENT ID IS %@", reg_id);
//            }
//            
//            if (containsError != 1) {
//                [self performSegueWithIdentifier:@"loginSuccessful" sender:nil];
//            }
//            [self.indicator stopAnimating];
//        });
//    });
//    
//    [self.indicator stopAnimating];
}

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

- (UIActivityIndicatorView *)indicator {
    if (!indicator) {
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return indicator;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
