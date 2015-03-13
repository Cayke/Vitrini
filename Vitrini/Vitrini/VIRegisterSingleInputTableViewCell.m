//
//  VIRegisterSingleInputTableViewCell.m
//  Vitrini
//
//  Created by Willian Pinho on 3/5/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIRegisterSingleInputTableViewCell.h"
#import "VIColor.h"

@implementation VIRegisterSingleInputTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _singleInput.tintColor = [VIColor darkWhiteVIColor];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
