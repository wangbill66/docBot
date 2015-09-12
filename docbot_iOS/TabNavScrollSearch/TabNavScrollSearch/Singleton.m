//
//  Singleton.m
//  TabNavScrollSearch
//
//  Created by Bill on 8/17/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton
{

}

@synthesize Token, svcUsername, svcPassword, ehrUsername, ehrPassword, appname, reply, dataReply;


+ (id)sharedManager {
    static Singleton *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        svcUsername = @"DocBo-511f-docbotdemo-test";
        svcPassword = @"D!4B!tDecBct-d7M!t1st@pp4d4Dc";
        url = @"http://twlatestga.unitysandbox.com";
        //========= MAGIC ACTION fields
        ehrUsername = @"jmedici";
        ehrPassword = @"";
        appname = @"DocBot.docbot-demo.TestApp";
        //=============TOKEN
        Token = @"Token_Singleton";
        
        reply = nil;
        
        dataReply = nil;

    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (NSData *) magicAction: (NSString *)actionMA with: (NSString *) appnameMA with: (NSString *)appUserIDMA with: (NSString *)patientIDMA with: (NSString *)tokenMA with1: (NSString *) param1 with2: (NSString *) param2 with3: (NSString *) param3 with4: (NSString *) param4 with5: (NSString *) param5 with6: (NSString *) param6 with: (NSString *) dataMA {
    
//    NSLog(@"Action sent to Allscripts is: %@", actionMA);
    NSError *error;
    
    NSDictionary *MagicInfo = @{
                                @"Action" : actionMA,
                                @"Appname" : appnameMA,
                                @"AppUserID" : appUserIDMA,
                                @"PatientID" : patientIDMA,
                                @"Token" : tokenMA,
                                @"Parameter1" : param1,
                                @"Parameter2" : param2,
                                @"Parameter3" : param3,
                                @"Parameter4" : param4,
                                @"Parameter5" : param5,
                                @"Parameter6" : param6,
                                @"Data" : dataMA, };
    
    //Optional
//    NSString *stringRepMagic = [NSString stringWithFormat:@"%@", MagicInfo];
//    NSLog(@"This is json input: %@", stringRepMagic);
    //=====
    
    NSData *postDataMagic = [NSJSONSerialization dataWithJSONObject:MagicInfo options:0 error:&error];
    
    NSMutableURLRequest *requestMagic = [[NSMutableURLRequest alloc] init];
    
    [requestMagic setURL:[NSURL URLWithString:@"http://twlatestga.unitysandbox.com/Unity/UnityService.svc/json/MagicJson"]];
    [requestMagic setHTTPMethod:@"POST"];
    [requestMagic setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestMagic setHTTPBody:postDataMagic];
    
    NSURLConnection *connectionMagic = [[NSURLConnection alloc]initWithRequest:requestMagic delegate:self];
    
    if(connectionMagic) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
//    __block NSData *dataReply;
    
    NSURLSession *sessionMagic = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[sessionMagic dataTaskWithRequest:requestMagic completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *MagicReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        
//        NSLog(@"Magic Reply: %@", MagicReply);
        
        dataReply = data;
//        NSLog(@"ALLSCRIPTS PAGE before resume: %@", dataReply);
    }] resume];
    
//    NSLog(@"ALLSCRIPTS PAGE: %@", dataReply);
    return dataReply;
}

- (NSString *) authenticate: (NSString *)usernameA with: (NSString *)passwordA {
    Singleton *shared = [Singleton sharedManager];
    
    NSError *error;
    
    NSDictionary *loginInfo = @{ @"Username" : usernameA, @"Password" : passwordA};
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:loginInfo options:0                                                         error:&error];
    
//    NSString *stringRep = [NSString stringWithFormat:@"%@", loginInfo];
//    NSLog(@"This is json input: %@", stringRep);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:@"http://twlatestga.unitysandbox.com/Unity/unityservice.svc/json/GetToken"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if(connection) {
        NSLog(@"Connection Successful");
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSString *TokenReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            
            shared.Token = TokenReply;
            
//            NSLog(@"Token Reply: %@", TokenReply);
        }] resume];
        
        return shared.Token;
        
    } else {
        NSLog(@"Connection could not be made");
    }
    
    return @"SOMETHING WENT WRONG O_O";
    
    
}



@end
