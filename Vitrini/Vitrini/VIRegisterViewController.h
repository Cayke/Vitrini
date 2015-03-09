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


@interface VIRegisterViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray *fields;

//Provavelmente vai precisar
@property (nonatomic) NSArray *arrayOfSections;
@property (nonatomic) VIUser *auxUser;

@property (nonatomic) NSString *facebookID;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *gender;
@property (nonatomic) NSString *birthday;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *pass;

@end
