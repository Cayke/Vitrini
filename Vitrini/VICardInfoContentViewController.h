//
//  VICardInfoContentViewController.h
//  Vitrini
//
//  Created by Cayke Prudente on 06/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VICardInfoContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;


@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;

@end
