//
//  VIProductsCollectionCell.h
//  Vitrini
//
//  Created by Riheldo Melo Santos on 11/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AsyncImageView.h"

@interface VIProductsCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet AsyncImageView *imageView;

-(void)mountWithDict:(NSDictionary*)dict;

@end
