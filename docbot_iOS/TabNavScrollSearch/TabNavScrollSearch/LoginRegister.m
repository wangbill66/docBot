//
//  LoginRegister.m
//  TabNavScrollSearch
//
//  Created by Bill on 8/28/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import "LoginRegister.h"
#import "KeychainItemWrapper.h"
#import "Login.h"

@interface LoginRegister ()

@end

@implementation LoginRegister {
    NSString *isAlreadyLoggedIn;
    UIActivityIndicatorView *indicator;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"DocBotLoginData" accessGroup:nil];
    
//    [keychainItem resetKeychainItem];
    
    NSData *passwordData = [keychainItem objectForKey:(__bridge id)(kSecValueData)];
    NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSASCIIStringEncoding];
    NSString *username = [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
    
//    NSLog(@"Username is %@", username);
//    NSString *className = NSStringFromClass([password class]);
//    NSLog(className);
    
    self.indicator.center = self.view.center;
    [self.view addSubview:self.indicator];
    [indicator startAnimating];
    
    
    //CAN"T MAKE THIS TO WORK!!!?!
    NSLog(@"username is :%@", username);
    if (![username isEqualToString:@""]) {
    [indicator startAnimating];
    
    //======Keep editing!!!!!!!!!!!!!!!!!!!!!
    Login *loginBoard = [[Login alloc] init];
    [loginBoard authenticateDocbot:nil with:username with:password with:nil];
        
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        
        isAlreadyLoggedIn = @"yes";
        
        dispatch_sync(dispatch_get_main_queue(), ^{

            
        });
    });
        
    }
    
    
//    if (password != nil && username != nil) {
//        self.indicator.center = self.view.center;
//        [self.view addSubview:self.indicator];
//        [indicator startAnimating];
//  
//        isAlreadyLoggedIn = @"yes";
//    }
}

- (UIActivityIndicatorView *)indicator {
    if (!indicator) {
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return indicator;
}

-(void) viewDidAppear:(BOOL)animated {
    if ([isAlreadyLoggedIn isEqualToString:@"yes"]) {
        [self performSegueWithIdentifier:@"AlreadyLoggedIn" sender:self];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
