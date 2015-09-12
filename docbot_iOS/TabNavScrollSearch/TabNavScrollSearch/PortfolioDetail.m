//
//  PortfolioDetail.m
//  TabNavScrollSearch
//
//  Created by Bill on 8/20/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import "PortfolioDetail.h"

@interface PortfolioDetail ()

@end

@implementation PortfolioDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _NameTag.text = _nameInfo;
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
