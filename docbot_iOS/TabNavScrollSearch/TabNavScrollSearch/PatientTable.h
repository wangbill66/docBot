//
//  PatientTable.h
//  TabNavScrollSearch
//
//  Created by Bill on 8/7/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientObject.h"
#import "DetailViewController.h"
#import "PatientObject.h"
#import "PatientCellBlock.h"

@interface PatientTable : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, weak) IBOutlet UISearchBar *patientSearch;

//@property (nonatomic,strong) NSArray *listOfPatients;

@end
