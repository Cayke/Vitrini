//
//  VIProductNameAndPriceTableViewCell.m
//  Vitrini
//
//  Created by Cayke Prudente on 15/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIProductNameAndPriceTableViewCell.h"
#import "VIColor.h"

@implementation VIProductNameAndPriceTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)mountWithName:(NSString *)name andPrice:(float)price
{
    _productName.text = name;
    if (price > 0 ) {
            _productPrice.text = [NSString stringWithFormat:@"R$%.0f", price];
        _productPrice.hidden = NO;
    }
    else
    {
        _productPrice.hidden = YES;
    }

}

@end
