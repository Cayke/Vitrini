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
        //        //iphone 4
        //        _smallSquareCenter.constant = 37 ;
        //        _bigSquareCenter.constant = 37;
        //        _labelCenter.constant = -28;
        
        //iphone 6
        _smallSquareCenter.constant = 61 ;
        _bigSquareCenter.constant = 61;
        _labelCenter.constant = -29.5;
        
        _labelName.textAlignment = NSTextAlignmentLeft;
    }
    else
    {
        //        //iphone 4
        //        _smallSquareCenter.constant = -40 ;
        //        _bigSquareCenter.constant = -40;
        //        _labelCenter.constant = 25;
        
        //iphone 6
        _smallSquareCenter.constant = -67 ;
        _bigSquareCenter.constant = -67;
        _labelCenter.constant = 23.5;
        
        _labelName.textAlignment = NSTextAlignmentRight;
    }
}


@end
