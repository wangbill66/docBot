//
//  DetailViewController.m
//  TabNavScrollSearch
//
//  Created by Bill on 7/23/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import "DetailViewController.h"
#import "Singleton.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize nameInfo, patient_ID, dateOfBirth, age, gender, phone, email;
//@synthesize NameTag;
//@synthesize DetailTag;
//@synthesize PatientObj;

NSMutableArray *reply;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [scroller setScrollEnabled:YES];
//    [scroller setContentSize:CGSizeMake(320, 1000)];
    
    reply = nil;
    NSString *securityToken = @"";
    
    Singleton *shared = [[Singleton alloc] init];
    securityToken = [shared authenticate:shared.svcUsername with:shared.svcPassword];
    
    while ([securityToken isEqualToString:@""]) {
        
    }
    
    [shared magicAction:@"GetPatient" with:shared.appname with:shared.ehrUsername with:patient_ID with:securityToken with1:@"" with2:@"" with3:@"" with4:@"" with5:@"" with6:@"" with:@""];
    
    while (shared.dataReply == nil) {
        
    }
    
    NSError *jsonError;
    reply = [NSJSONSerialization JSONObjectWithData:shared.dataReply options:0 error:&jsonError];
//    [NSThread sleepForTimeInterval:0.5f];
    
    NSLog(@"%@", reply);
    
    for (NSDictionary *dick in reply) {
        
        NSLog(@"Dick is %@", dick);
        NSArray *subArray = [dick objectForKey:@"getpatientinfo"];
        NSLog(@"Subdick is %@", subArray);
        
        for (NSDictionary *subsubDick in subArray) {
            _dateOfBirthTag.text = subsubDick[@"dateofbirth"];
            _ageTag.text = subsubDick[@"age"];
            _genderTag.text = subsubDick[@"gender"];
            _phoneTag.text = subsubDick[@"PhoneNumber"];
            _emailTag.text = subsubDick[@"Email"];
        }
    }
    
    
    _NameTag.text = nameInfo;

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
