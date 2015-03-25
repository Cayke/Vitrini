//
//  VIRegisterViewController.h
//  Vitrini
//
//  Created by Cayke Prudente on 20/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIStoreProfileNavigationBar.h"
#import "VILoginViewController.h"

@interface VIRegisterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet VIStoreProfileNavigationBar *customNavBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) VILoginViewController *login;



@end
