//
//  VIProfileTableViewController.h
//  Vitrini
//
//  Created by Riheldo Melo Santos on 14/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VIProtocol.h"
#import "VIUser.h"

@interface VIProfileTableViewController : UITableViewController <VIViewControllerMenuItemProtocol>

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

@property (weak, nonatomic) IBOutlet UILabel *titlePhoto;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UIImageView *backPhoto;
@property (weak, nonatomic) IBOutlet UIView *layerBlurBackPhoto;


@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControll;

@end
