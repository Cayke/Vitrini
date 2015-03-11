//
//  VIProductsFromCategoryViewController.h
//  Vitrini
//
//  Created by Cayke Prudente on 10/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VICategory.h"

@interface VIProductsFromCategoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic) NSArray *arrayWithProducts;
@property (nonatomic) VICategory *category;

- (instancetype)initWithCategory:(VICategory *) category;

@end
