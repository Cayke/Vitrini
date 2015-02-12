//
//  VIFilterCollectionViewCell.m
//  Vitrini
//
//  Created by Cayke Prudente on 05/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIFilterCollectionViewCell.h"

@implementation VIFilterCollectionViewCell

-(void)mountWithPosition:(NSInteger)position
{
    //se for par e celula da esquerda, senao da direita...
    if (position%2 == 0) {
        _smallSquareCenter.constant = 37 ;
        _bigSquareCenter.constant = 37;
        _labelCenter.constant = -28;
        _labelName.textAlignment = NSTextAlignmentLeft;
    }
    else
    {
        _smallSquareCenter.constant = -40 ;
        _bigSquareCenter.constant = -40;
        _labelCenter.constant = 25;
        _labelName.textAlignment = NSTextAlignmentRight;
    }
}


@end
