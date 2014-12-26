//
//  VILikedsViewController.h
//  Vitrini
//
//  Created by Riheldo Melo Santos on 24/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIProtocol.h"

@interface VILikedsViewController : UIViewController
<VIViewControllerMenuItemProtocol, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
