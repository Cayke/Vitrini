//
//  UserOnboardViewController.h
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 11/28/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIInitControl.h"

@interface UserOnboardViewController : UIViewController <UIPageViewControllerDataSource>

//todo : imagens estarao no proprio device...

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageImages;
@property (strong, nonatomic) VIInitControl *initiControl;

- (IBAction)pular:(id)sender;

@end
