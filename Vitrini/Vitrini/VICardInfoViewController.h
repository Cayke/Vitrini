//
//  VICardInfoViewController.h
//  Vitrini
//
//  Created by Willian Pinho on 2/3/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VICardInfoViewController : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic) UIPageViewController *pageViewController;
@property (nonatomic) NSArray *pageImages;


@end
