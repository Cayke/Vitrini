//
//  VICardInfoViewController.h
//  Vitrini
//
//  Created by Willian Pinho on 2/3/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VICardInfoViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *photoProduct;

@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;

@end
