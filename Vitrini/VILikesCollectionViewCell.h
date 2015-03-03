//
//  VILikesCollectionViewCell.h
//  Vitrini
//
//  Created by Cayke Prudente on 03/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "VIProduct.h"

@interface VILikesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet AsyncImageView *productPhoto;

-(void) mountCellWithProduct:(VIProduct *) product;


@end
