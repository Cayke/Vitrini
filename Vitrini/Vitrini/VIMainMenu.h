//
//  VIMainMenu.h
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 12/16/14.
//  Copyright (c) 2014 Vitrini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIMainViewController.h"

#import "VIProtocol.h"

@class VIMainViewController;

@interface VIMainMenu : UIView <UITableViewDelegate, UITableViewDataSource>

@property VIMainViewController *viTabBarVC;
@property UITableView *table;

- (instancetype)initWithVITabBarVC:(VIMainViewController *)vitabbarvc andFrame:(CGRect)frame;

-(void)installIconsOnMenu;

-(void)showMenu;

-(void)hideMenu;


@end
