//
//  VILoginViewController.h
//  Vitrini
//
//  Created by Cayke Prudente on 20/01/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIInitControl.h"

@interface VILoginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic) VIInitControl *initiControl;

@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSenha;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBackground;
@property (weak, nonatomic) IBOutlet UIImageView *buttonFacebook;
@property (weak, nonatomic) IBOutlet UIImageView *buttonNewAcc;

//dados necessarios login FB : nome, id,email,celular,cidade...
@property (nonatomic) NSString *fbName;
@property (nonatomic) NSString *fbId;
@property (nonatomic) NSString *fbEmail;
@property (nonatomic) NSString *fbBirthday;
@property (nonatomic) NSString *fbCidade;
@property (nonatomic) NSString *fbGender;



@end
