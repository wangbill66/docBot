//
//  PatientPortfolioTable.m
//  TabNavScrollSearch
//
//  Created by Bill on 8/20/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import "PatientPortfolioTable.h"
#import "Singleton.h"
#import "AppDelegate.h"


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
    
    [NSThread sleepForTimeInterval:0.4f];
    
    while ([shared.Token isEqual: @"Token_Singleton"]) {
//
        [self viewDidLoad];
    }
    
    NSLog(@"TOKEN: %@", shared.Token);
    
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"DocBotLoginData" accessGroup:nil];
    
    NSString *allscriptsUsername = [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
    
    
    [shared magicAction:@"GetSchedule" with:shared.appname with:allscriptsUsername with:@"" with:shared.Token with1:dateRange with2:@"" with3:@"Y" with4:@"" with5:@"" with6:@"" with:@""];
    
    while (shared.dataReply == nil) {
        //
    }
    
    NSLog(@"%@", shared.dataReply);
    NSError *jsonError;
    reply = [NSJSONSerialization JSONObjectWithData:shared.dataReply options:0 error:&jsonError];
//    [NSThread sleepForTimeInterval:0.5f];
    
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
    
    //Sorting it.
    NSMutableArray *sortedArray;
    sortedArray = [listOfPatients sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first = [(PatientObject*)a name];
        NSString *second = [(PatientObject*)b name];
        return [first compare:second];
    }];
    
    listOfPatients = sortedArray;
    
    //===============filtering for Search
    filteredListOfPatients = [[NSMutableArray alloc] initWithCapacity:[listOfPatients count]];
    
    [self.tableView reloadData];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //===============
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"PatientPortfolioCell";
    
    PortfolioCellBlock *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if ( cell == nil )
    {
        cell = [[PortfolioCellBlock alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
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
    
    cell.name.text = patientToDisplay.name;
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    PatientObject *patientToSend = [listOfPatients objectAtIndex:indexPath.row];
    //    DetailViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PatientDetail"];
    //    newViewController.nameInfo = patientToSend.name;
    //    newViewController.detailInfo = patientToSend.detail;
    //
    //    [self.navigationController pushViewController:newViewController animated:YES];
    
    PatientObject *patientToSend = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        patientToSend = [filteredListOfPatients objectAtIndex:indexPath.row];
    }
    
    else
    {
        patientToSend = [listOfPatients objectAtIndex:indexPath.row];
    }
    
    PortfolioDetail *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PortfolioDetail"];
    
    //    newViewController.detailInfo = patientToSend.arrivalTime;
    newViewController.nameInfo = patientToSend.name;
    newViewController.patient_ID = patientToSend.patient_ID;
    
    [self.navigationController pushViewController:newViewController animated:YES];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [filteredListOfPatients removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@", searchText];
    filteredListOfPatients = [NSMutableArray arrayWithArray:[listOfPatients filteredArrayUsingPredicate:predicate]];
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
