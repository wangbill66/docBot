//
//  EHRPage.m
//  TabNavScrollSearch
//
//  Created by Bill on 8/24/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import "EHRPage.h"
#import "Singleton.h"
#import "KeychainItemWrapper.h"

@interface EHRPage ()

@end


@implementation EHRPage {
    UIActivityIndicatorView *indicator;
}

@synthesize doneButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"AllscriptsData" accessGroup:nil];
    
    NSString *username = [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
  
    if (username == nil || [username isEqualToString:@""]) {
        doneButton.hidden = YES;
    }
    
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

- (IBAction)doneButtonPressed:(id)sender {
    
    self.indicator.center = self.view.center;
    self.indicator.color = [UIColor blackColor];
    [self.view addSubview:self.indicator];
    [self.indicator startAnimating];
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (UIActivityIndicatorView *)indicator {
    if (!indicator) {
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return indicator;
}


@end
