//
//  VILikesViewController.h
//  Vitrini
//
//  Created by Cayke Prudente on 03/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIProtocol.h"

@interface VILikesViewController : UIViewController <VIViewControllerMenuItemProtocol, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) NSArray *arrayWithProducts;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionVIew;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic) BOOL isLoading;
@property (nonatomic) int categoryOnFilter;


-(void) getLikesWithCategory:(int) categoryID;

@end
