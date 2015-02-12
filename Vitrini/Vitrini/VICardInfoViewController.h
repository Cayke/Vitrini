//
//  VICardInfoViewController.h
//  Vitrini
//
//  Created by Willian Pinho on 2/3/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VICardInfoViewController : UIViewController <UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic) UIPageViewController *pageViewController;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControlNB;
@property (nonatomic) NSArray *pageImages;

@property (weak, nonatomic) IBOutlet UINavigationBar *customNavigationBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageControlCenter;

- (IBAction)back:(id)sender;


@end
