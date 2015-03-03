//
//  VILikesCollectionViewCell.m
//  Vitrini
//
//  Created by Cayke Prudente on 03/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VILikesCollectionViewCell.h"

@implementation VILikesCollectionViewCell

-(void)mountCellWithProduct:(VIProduct *)product
{
    _productPhoto.activityIndicatorStyle = UIActivityIndicatorViewStyleWhiteLarge;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://107.170.189.125/vitrini/default/download/db/%@", product.photoString]];
    _productPhoto.imageURL = url;
}

@end
