//
//  Settings.m
//  TabNavScrollSearch
//
//  Created by Bill on 8/28/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import "Settings.h"
#import "KeychainItemWrapper.h"

@interface Settings ()

@end

@implementation Settings

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"DocBotLoginData" accessGroup:nil];
    
//    NSData *allScriptsUser = [keychainItem objectForKey:(__bridge id)(kSecAttrComment)];
//    NSLog(allScriptsUser);

    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
