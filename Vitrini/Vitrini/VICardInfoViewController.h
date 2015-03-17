//
//  VICardInfoViewController.h
//  Vitrini
//
//  Created by Cayke Prudente on 2/3/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIProduct.h"
#import "VIStoreProfileNavigationBar.h"


@interface VICardInfoViewController : UIViewController <UIPageViewControllerDataSource,UIPageViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

//produto a ser mostrado
@property (nonatomic) VIProduct *product;
@property  (nonatomic) BOOL productDidLoad;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) UIPageViewController *pageViewController;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControlNB;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet VIStoreProfileNavigationBar *customNavigationBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageControlCenter;

@property (nonatomic) float tableHeaderHeight;
@property (nonatomic) float pageViewControlllerHeight;
@property (nonatomic) float textViewHeight;

- (IBAction)locationButton:(id)sender;
- (IBAction)shareButton:(id)sender;

@end
