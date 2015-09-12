//
//  PatientTable.m
//  TabNavScrollSearch
//
//  Created by Bill on 8/7/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import "PatientTable.h"
#import "Singleton.h"
#import "PatientObject.h"
#import "KeychainItemWrapper.h"
#import "AppDelegate.h"

@interface PatientTable ()

@end

@implementation PatientTable {
    
    NSString *patientTableToken;
    
    NSString *todayDate;
    
    NSMutableArray *listOfPatients;
    
    NSMutableArray *filteredListOfPatients;
    
    NSMutableArray *reply;
    
//    Singleton *sharedM;
    
    UIActivityIndicatorView *indicator;
}

//@synthesize listOfPatients;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.indicator.center = CGPointMake(150, 150);
    [self.view addSubview:self.indicator];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
//    NSLog([delegate.linkKeychain objectForKey:(__bridge id)(kSecAttrAccount)]);
    
    listOfPatients = [[NSMutableArray alloc] init];
    
    // Today's date.
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    todayDate = [dateString substringWithRange:NSMakeRange(0, 7)];
    
    //delete This
    todayDate = @"2/17/2015|3/17/2015";
    
    
    Singleton *shared = [Singleton sharedManager];
    //    NSLog(@"C1");
    
    //    NSString *securityToken = @"";
    //
    [shared authenticate:shared.svcUsername with:shared.svcPassword];
    //
    //    while ([securityToken isEqualToString:@""]) {
    //
    //    }
//    [NSThread sleepForTimeInterval:1.0];
    
    while ([shared.Token isEqual: @"Token_Singleton"]) {
//        [self viewDidLoad];
    }
    
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"AllscriptsData" accessGroup:nil];
    
    NSString *allscriptsUsername = [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
    
    //    NSLog(@"TOKEN: %@", shared.Token);
    NSString *magicAct = @"GetSchedule";
    [shared magicAction:magicAct with:shared.appname with:allscriptsUsername with:@"" with:shared.Token with1:todayDate with2:@"" with3:@"Y" with4:@"" with5:@"" with6:@"" with:@""];
    
    while (shared.dataReply == nil) {
        
    }
    
    //    NSLog(@"%@", shared.dataReply);
    NSError *jsonError;
    [NSThread sleepForTimeInterval:1.0];
    reply = [NSJSONSerialization JSONObjectWithData:shared.dataReply options:0 error:&jsonError];
//    [NSThread sleepForTimeInterval:0.5f];
    
    //    NSLog(@"C4");
    //    NSLog(@"PatientTable reply is %@", reply);
    
    //reply --> Array
    //for dick in reply --> dictionary
    //for subArray in dick ==> array
    //for subsubDick in subArray ==> Dictionary
    
    // NSArray -> NSDictionary -> NSArray -> NSDictionary
    
    for (NSDictionary *dick in reply) {
        //        NSLog(@"C1");
        //        NSLog(@"Dick is %@", dick);
        NSArray *subArray = [dick objectForKey:@"getscheduleinfo"];
        //        NSLog(@"Subdick is %@", subArray);
        
        for (NSDictionary *subsubDick in subArray) {
            //            NSLog(@"%@", subsubDick);
            //            NSLog(@"%@", subsubDick[@"Duration"]);
            //            NSLog(@"C2");
            PatientObject *currPatient = [[PatientObject alloc] init];
            currPatient.name = [NSString stringWithFormat:@"%@ %@", subsubDick[@"PatientFirstName"], subsubDick[@"PatientLastName"]];
            currPatient.arrivalTime = subsubDick[@"TimeIn"];
            currPatient.patient_ID = subsubDick[@"patientID"];
            [listOfPatients addObject:currPatient];
            //            NSLog(@"%@", currPatient.name);
            //            NSLog(@"CHECKPOINT %lu", (unsigned long)[listOfPatients count]);
        }
    }
    
    //Sorting it.
    NSMutableArray *sortedArray;
    sortedArray = [listOfPatients sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first = [(PatientObject*)a arrivalTime];
        NSString *second = [(PatientObject*)b arrivalTime];
        return [first compare:second];
    }];
    
    listOfPatients = sortedArray;
    
    
    //===============filtering for Search
    filteredListOfPatients = [[NSMutableArray alloc] initWithCapacity:[listOfPatients count]];
    
    [self.tableView reloadData];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //===============
    
    //    [{"getscheduleinfo":
    //        [{
    //        "Status":"Arr",
    //        "Location":"New World Health - Main Location",
    //        "SchedComment":"",
    //        "patientmiddlename":"",
    //        "Patient":"Test, Oncology",
    //        "Duration":"15",
    //        "SchedText":"",
    //        "organizationMRN":"040506135757487",
    //        "ApptTime":"02/17/2015 10:00:00 AM",
    //        "type":"NEW T60",
    //        "TimeIn":"10:00",
    //        "base64image":"",
    //        "TimeStart":"10:00",
    //        "TimeOut":"10:15",
    //        "Comment":"",
    //        "PatientLastName":"Test",
    //        "PatientFirstName":"Oncology",
    //        "Encounterid":"14368",
    //        "patientID":"73"
    //        }]}]
    
    
    //================
    //    NSError *jsonError;
    //    reply = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
    //
    //
    //    NSString *TokenReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    //    NSLog(@"Token Reply: %@", TokenReply);
    //==================
    
    
    //     Uncomment the following line to
    //    preserve selection between presentations.
    //     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatingTableView) name:@"reload_data" object:nil];

    
}

- (UIActivityIndicatorView *)indicator {
    if (!indicator) {
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return indicator;
}

-(void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    
}

-(void)updatingTableView{
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
//    NSLog(@"numberOfSectionsInTableView");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"NumberofRowsInSection");
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [filteredListOfPatients count];
    }
//    NSLog(@"listOfPatients: %@", [listOfPatients count]);
    return [listOfPatients count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSLog(@"CellforRowAt");
    
    static NSString *simpleTableIdentifier = @"PatientCell";

    PatientCellBlock *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if ( cell == nil )
    {
        cell = [[PatientCellBlock alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
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
  
    cell.nameLabel.text = patientToDisplay.name;
    
    cell.arrivalTimeLabel.text = patientToDisplay.arrivalTime;
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
    
    //===================
    
    PatientObject *person = [listOfPatients objectAtIndex:indexPath.row];
    
    UILabel *personNameLabel = (UILabel *)[cell viewWithTag:101];
    personNameLabel.text = person.name;
    
    UILabel *personDetailLabel = (UILabel *)[cell viewWithTag:102];
//    personDetailLabel.text = person.detail;
    
    
    
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
    
    DetailViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PatientDetail"];

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

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"showPatientDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        DetailViewController *destViewController = segue.destinationViewController;
//        destViewController.PatientObj = [listOfPatients objectAtIndex:indexPath.row];
//    }
//}

//        DetailViewController *destViewController = segue.destinationViewController;
//        destViewController.recipe = [recipes objectAtIndex:indexPath.row];
        
        // Hide bottom tab bar in the detail view
        //   destViewController.hidesBottomBarWhenPushed = YES;


@end
