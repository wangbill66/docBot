//
//  Singleton.h
//  TabNavScrollSearch
//
//  Created by Bill on 8/17/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject
{

    //=========TOKEN fields
    NSString *svcUsername;
    NSString *svcPassword;
    NSString *url;
    //========= MAGIC ACTION fields
    NSString *ehrUsername;
    NSString *ehrPassword;
    NSString *appname;
    //=============TOKEN
    NSString *Token;
    
    NSDictionary *reply;
    
    NSData *dataReply;
    
//    NSInteger count;
}

// Your property settings for your variables go here
// here's one example:
@property (nonatomic, retain) NSString *Token;
@property (nonatomic, retain) NSString *svcUsername;
@property (nonatomic, retain) NSString *svcPassword;
@property (nonatomic, retain) NSString *ehrUsername;
@property (nonatomic, retain) NSString *ehrPassword;
@property (nonatomic, retain) NSString *appname;
@property (nonatomic, retain) NSDictionary *reply;
@property (nonatomic, retain) NSData *dataReply;

//don't think it's actually used.
//@property (nonatomic, retain) NSInteger count;

// This is the method to access this Singleton class
+ (id)sharedManager;
- (NSData *) magicAction: (NSString *)actionMA with: (NSString *) appnameMA with: (NSString *)appUserIDMA with: (NSString *)patientIDMA with: (NSString *)tokenMA with1: (NSString *) param1 with2: (NSString *) param2 with3: (NSString *) param3 with4: (NSString *) param4 with5: (NSString *) param5 with6: (NSString *) param6 with: (NSString *) dataMA;
- (NSString *) authenticate: (NSString *)usernameA with: (NSString *)passwordA;
//-(void) incrementCount;
//-(NSInteger) retCount;
@end
