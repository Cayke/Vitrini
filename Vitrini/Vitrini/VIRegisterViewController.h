//
//  VIRegisterViewController.h
//  Vitrini
//
//  Created by Cayke Prudente on 20/01/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIUser.h"
#import "VIRegisterSingleInputTableViewCell.h"


@interface VIRegisterViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray *fields;

//Provavelmente vai precisar
@property (nonatomic) NSArray *arrayOfSections;
@property (nonatomic) VIUser *auxUser;

@property (nonatomic,weak) VIRegisterSingleInputTableViewCell *rsitvc;
@end
