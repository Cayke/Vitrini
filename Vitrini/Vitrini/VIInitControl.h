//
//  VIInitControl.h
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 12/16/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface VIInitControl : NSObject

@property(nonatomic, weak)AppDelegate *appDelegate;

- (void)start;
- (void)goToLogin;
- (void)goToMainApp;

@end
