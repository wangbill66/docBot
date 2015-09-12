//
//  PatientCellBlock.m
//  TabNavScrollSearch
//
//  Created by Bill on 8/7/15.
//  Copyright (c) 2015 Bill. All rights reserved.
//

#import "PatientCellBlock.h"

@implementation PatientCellBlock

- (void)awakeFromNib {
    // Initialization code
}

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
//    {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        _nameLabel = [[UILabel alloc] initWithFrame:(CGRectMake(107, 8, 173, 42))];
//        _nameLabel.font = [UIFont systemFontOfSize:17];
//        _nameLabel.textAlignment = NSTextAlignmentCenter;
//        
//        _detailLabel = [[UILabel alloc] initWithFrame:(CGRectMake(137, 49, 113, 21))];
//        _detailLabel.font = [UIFont systemFontOfSize:13];
//        _detailLabel.textAlignment = NSTextAlignmentCenter;
//    
//        [self.contentView addSubview:_nameLabel];
//        [self.contentView addSubview:_detailLabel];
//    }
    return self;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
