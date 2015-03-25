//
//  VIFilterViewController.h
//  Vitrini
//
//  Created by Cayke Prudente on 05/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VILikesViewController.h"

@protocol VIFilterDelegate <NSObject>

-(void)loadWithCategoryID:(int)categoryID;

@end



@interface VIFilterViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) NSArray *arrayWithCategories;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) VILikesViewController *likesVC;
@property (nonatomic) NSObject *vcDelegate;

@property (nonatomic) int categoryOnFilter;

@end
