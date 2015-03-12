//
//  VIStoreProfileViewController.h
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 2/3/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "VIStore.h"

@interface VIStoreProfileViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic) VIStore *actualStore;

@end
