//
//  VILikedProductCell.h
//  Vitrini
//
//  Created by Cayke Prudente on 02/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VIProduct.h"

@interface VILikedProductCell : UICollectionViewCell

-(void)mountWithProduct:(VIProduct*)product;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
