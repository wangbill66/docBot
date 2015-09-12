//
//  DetailViewController.h
//  TabNavScrollSearch
//
//  Created by Bill on 7/23/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientObject.h"

@interface DetailViewController : UIViewController

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



//@property (weak, nonatomic) IBOutlet UITextView *DetailTag;
// ==need?
@property (nonatomic, strong) PatientObject *PatientObj;

@end
