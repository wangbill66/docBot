//
//  PatientPortfolioTable.m
//  TabNavScrollSearch
//
//  Created by Bill on 8/20/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import "PatientPortfolioTable.h"
#import "Singleton.h"

@interface PatientPortfolioTable ()

@end

@implementation PatientPortfolioTable {
    NSMutableArray *listOfPatients;
    
    NSMutableArray *filteredListOfPatients;
    
    NSMutableArray *reply;
    
    NSString *dateRange;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.greekLetters = @[@"a", @"b"];
    
    listOfPatients = [[NSMutableArray alloc] init];
    
    // date range (1 month) change this.
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    dateRange = [dateString substringWithRange:NSMakeRange(0, 7)];
    
    //delete This
    dateRange = @"2/17/2015|3/17/2015";
    
    
    Singleton *shared = [Singleton sharedManager];
    NSLog(@"C1");
    
    //    NSString *securityToken = @"";
    //
    [shared authenticate:shared.svcUsername with:shared.svcPassword];
    //
    //    while ([securityToken isEqualToString:@""]) {
    //
    //    }
    [NSThread sleepForTimeInterval:1.2f];
    
    if ([shared.Token isEqual: @"Token_Singleton"]) {
        [self viewDidLoad];
    }
    
    NSLog(@"TOKEN: %@", shared.Token);
    
    [shared magicAction:@"GetSchedule" with:shared.appname with:shared.ehrUsername with:@"" with:shared.Token with1:dateRange with2:@"" with3:@"Y" with4:@"" with5:@"" with6:@"" with:@""];
    
    while (shared.dataReply == nil) {
        //
    }
    
    NSLog(@"%@", shared.dataReply);
    NSError *jsonError;
    reply = [NSJSONSerialization JSONObjectWithData:shared.dataReply options:0 error:&jsonError];
    [NSThread sleepForTimeInterval:0.5f];
    
    NSLog(@"C4");
    NSLog(@"%@", reply);
    
    
    
    //reply --> Array
    //for dick in reply --> dictionary
    //for subArray in dick ==> array
    //for subsubDick in subArray ==> Dictionary
    
    // NSArray -> NSDictionary -> NSArray -> NSDictionary
    
    for (NSDictionary *dick in reply) {
        
        NSLog(@"Dick is %@", dick);
        NSArray *subArray = [dick objectForKey:@"getscheduleinfo"];
        NSLog(@"Subdick is %@", subArray);
        
        for (NSDictionary *subsubDick in subArray) {
            NSLog(@"%@", subsubDick);
            NSLog(@"%@", subsubDick[@"Duration"]);
            
            PatientObject *currPatient = [[PatientObject alloc] init];
            currPatient.name = [NSString stringWithFormat:@"%@ %@", subsubDick[@"PatientFirstName"], subsubDick[@"PatientLastName"]];
            currPatient.arrivalTime = subsubDick[@"TimeIn"];
            currPatient.patient_ID = subsubDick[@"patientID"];
            [listOfPatients addObject:currPatient];
            NSLog(@"%@", currPatient.name);
            NSLog(@"CHECKPOINT %lu", (unsigned long)[listOfPatients count]);
        }
    }
    
    //===============filtering
    filteredListOfPatients = [[NSMutableArray alloc] initWithCapacity:[listOfPatients count]];
    
//    [self.tableView reloadData];
//    
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //===============
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [filteredListOfPatients count];
    }
    
    else
    {
        return [listOfPatients count];
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *SimpleIdentifer = @"PatientPortfolioCell";
                            //self.
    PortfolioCellBlock *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifer];
    
    if (cell == nil) {
        cell = [[PortfolioCellBlock alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleIdentifer];
    }
    PatientObject *patientToDisplay = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        patientToDisplay = [filteredListOfPatients objectAtIndex:indexPath.row];
    }
    
    else
    {
        //        patientToDisplay = [patientHolderArray objectAtIndex:indexPath.row];
        patientToDisplay = [listOfPatients objectAtIndex:indexPath.row];
    }
    
    
    //    PatientObject *patientToDisplay = [listOfPatients objectAtIndex:indexPath.row];
    
//    cell.nameLabel.text = patientToDisplay.name;
//
//    cell.arrivalTimeLabel.text = patientToDisplay.arrivalTime;
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
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
