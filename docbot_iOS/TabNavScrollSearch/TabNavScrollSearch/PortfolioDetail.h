//
//  PortfolioDetail.h
//  TabNavScrollSearch
//
//  Created by Bill on 8/20/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientObject.h"

@interface PortfolioDetail : UIViewController

@property (nonatomic, strong) NSString *patient_ID;


@property (nonatomic, strong) NSString *nameInfo;
@property (nonatomic, strong) NSString *dateOfBirth;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *email;


@property (weak, nonatomic) IBOutlet UILabel *NameTag;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirthTag;
@property (weak, nonatomic) IBOutlet UILabel *ageTag;
@property (weak, nonatomic) IBOutlet UILabel *genderTag;
@property (weak, nonatomic) IBOutlet UILabel *phoneTag;
@property (weak, nonatomic) IBOutlet UILabel *emailTag;

@property (nonatomic, strong) PatientObject *PatientObj;


//@property (weak, nonatomic) IBOutlet UITextView *DetailTag;
// ==need?


@end
