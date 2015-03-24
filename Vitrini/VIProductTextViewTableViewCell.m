//
//  VIProductTextViewTableViewCell.m
//  Vitrini
//
//  Created by Cayke Prudente on 15/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIProductTextViewTableViewCell.h"
#import "VIColor.h"

@implementation VIProductTextViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)mountWithDescription:(NSString *)productDescription
{
    _productDescription.text = productDescription;
    [_productDescription setFont:[UIFont fontWithName:@"HelveticaNeue-Regular" size:15.0]];
    [_productDescription setTextColor:[VIColor whiteVIColor]];

}

@end
