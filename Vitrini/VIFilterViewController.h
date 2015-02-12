//
//  VIFilterViewController.h
//  Vitrini
//
//  Created by Cayke Prudente on 05/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIFilterViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (nonatomic) NSMutableArray *arrayWithCategories;

@end