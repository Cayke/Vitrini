//
//  UserOnboardContentViewController.h
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 11/28/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserOnboardContentViewController : UIViewController

@property NSUInteger pageIndex;

@property NSString *imageName;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
