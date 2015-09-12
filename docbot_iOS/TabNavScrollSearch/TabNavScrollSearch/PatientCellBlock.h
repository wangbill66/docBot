//
//  PatientCellBlock.h
//  TabNavScrollSearch
//
//  Created by Bill on 8/7/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientCellBlock : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *arrivalTimeLabel;
@property (nonatomic, strong) IBOutlet UILabel *typeOfEHR;



//@property (nonatomic, weak) NSString *nameLabel;
//@property (nonatomic, weak) NSString *detailLabel;

@end
