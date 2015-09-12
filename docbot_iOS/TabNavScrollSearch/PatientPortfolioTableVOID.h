//
//  PatientPortfolioTable.h
//  TabNavScrollSearch
//
//  Created by Bill on 8/20/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientObject.h"
#import "PortfolioDetail.h"
#import "PatientObject.h"
#import "PortfolioCellBlock.h"

@interface PatientPortfolioTable : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, weak) IBOutlet UISearchBar *patientPortfolioSearch;

@property (nonatomic, strong) NSMutableArray *greekLetters;

@end
