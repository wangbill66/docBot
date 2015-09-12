//
//  EHRPage.h
//  TabNavScrollSearch
//
//  Created by Bill on 8/24/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHRPage : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

- (IBAction)doneButtonPressed:(id)sender;

@end
