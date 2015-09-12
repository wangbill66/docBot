//
//  AppDelegate.h
//  TabNavScrollSearch
//
//  Created by Bill on 7/23/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *allscriptsUsername;

@property (strong, nonatomic) KeychainItemWrapper *linkKeychain;


@end

