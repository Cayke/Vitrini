//
//  VIProfileViewController.h
//  Vitrini
//
//  Created by Cayke Prudente on 04/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIProtocol.h"

@interface VIProfileViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, VIViewControllerMenuItemProtocol>

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)logOut:(id)sender;

//constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBackground;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightPhoto;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthPhoto;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalAligmentPhoto;

@property (nonatomic) NSArray *rowsTableView;


@end
