//
//  VIProductsCollectionCell.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 11/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIProductsCollectionCell.h"

@implementation VIProductsCollectionCell

-(void)mountWithDict:(NSDictionary *)dict{
    _imageView.activityIndicatorStyle = UIActivityIndicatorViewStyleWhiteLarge;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://107.170.189.125/vitrini/default/download/db/%@", [dict objectForKey:@"photo"]]];
    _imageView.imageURL = url;
}

@end
