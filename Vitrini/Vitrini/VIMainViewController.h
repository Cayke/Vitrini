//
//  VIMainViewController.h
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 12/16/14.
//  Copyright (c) 2014 Vitrini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIMainMenu.h"

@class VIMainMenu;

@interface VIMainViewController : UITabBarController

@property VIMainMenu *mainMenu;

-(void)changeVCtoIndex:(NSUInteger)index;

@end
