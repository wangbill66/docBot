//
//  PortfolioNavigation.m
//  TabNavScrollSearch
//
//  Created by Bill on 8/20/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import "PortfolioNavigation.h"

@interface PortfolioNavigation ()

@end

@implementation PortfolioNavigation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
    
    
    NSShadow * shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blueColor];
    //    shadow.shadowOffset = CGSizeMake(0, -2);
    
    NSDictionary * navBarTitleTextAttributes =
    @{ NSForegroundColorAttributeName : [UIColor colorWithRed:197/255.0f green:245/255.0f blue:255/255.0f alpha:1.0f],
       NSShadowAttributeName          : shadow,
       NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:24.0] };
    
    
    [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleTextAttributes];
    
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

@end
