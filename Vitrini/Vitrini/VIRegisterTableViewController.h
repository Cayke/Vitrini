//
//  VIRegisterTableViewController.h
//  Vitrini
//
//  Created by Willian Pinho on 3/13/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIUser.h"

@interface VIRegisterTableViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UITextField *inputName;
@property (weak, nonatomic) IBOutlet UITextField *inputGender;
@property (weak, nonatomic) IBOutlet UITextField *inputBirthday;
@property (weak, nonatomic) IBOutlet UITextField *inputCity;

@property (weak, nonatomic) IBOutlet UITextField *inputEmail;
@property (weak, nonatomic) IBOutlet UITextField *inputPass;
@property (weak, nonatomic) IBOutlet UITextField *inputConfirmPass;


@property (nonatomic) VIUser *auxUser;
@property (nonatomic) NSString *facebookID;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *gender;
@property (nonatomic) NSString *birthday;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *pass;
@property (nonatomic) NSString *confirmPass;

@end
