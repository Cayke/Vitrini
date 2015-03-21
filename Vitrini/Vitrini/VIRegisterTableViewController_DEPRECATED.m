//
//  VIRegisterTableViewController.m
//  Vitrini
//
//  Created by Willian Pinho on 3/13/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIRegisterTableViewController_DEPRECATED.h"
#import "VIColor.h"
#import "VIServer.h"
#import "VIStorage.h"
#import "VIInitControl.h"

@interface VIRegisterTableViewController_DEPRECATED ()

@end

@implementation VIRegisterTableViewController_DEPRECATED

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.contentInset = UIEdgeInsetsMake(-1.0f, 0.0f, 0.0f, 0.0);
    
    UIView *auxView = [[UIView alloc]initWithFrame:self.view.frame];
    [auxView addSubview:self.view];
    self.view = auxView;
    
    
    UIView *statusBarColor = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, 20)];
    statusBarColor.backgroundColor = [VIColor whiteVIColor];
    [auxView addSubview:statusBarColor];
    
    ///Navigation Bar
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *voltar = [[UIBarButtonItem alloc]initWithTitle:@"Cancelar" style:UIBarButtonItemStylePlain target:self action:@selector(voltar)];
    [voltar setTintColor:[VIColor whiteVIColor]];
    self.navigationItem.leftBarButtonItem = voltar;

    UIBarButtonItem *adicionar = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                               target:self action:@selector(registerUser)];
    
    [adicionar setTintColor:[VIColor whiteVIColor]];
    self.navigationItem.rightBarButtonItem = adicionar;
    
    //Title
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [VIColor whiteVIColor]};
    self.navigationItem.title = @"Criar Conta";
    self.navigationController.navigationBar.items = [NSArray arrayWithObject:self.navigationItem];

    
    
    ///Imagem da tableviewcontroller
    
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"viewBackground.png"]];    
    
    //Deixar Table View Transparente
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //delegates
    _inputName.delegate = self;
    _inputBirthday.delegate = self;
    _inputEmail.delegate = self;
    _inputPass.delegate = self;
    _inputConfirmPass.delegate = self;
    _inputCity.delegate = self;
    
    if (self.genderSC.selectedSegmentIndex == 0) {
        self.gender = @"M";
    }
    
    
    
    
    [_inputName setValue:[VIColor whiteVIColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_inputBirthday setValue:[VIColor whiteVIColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_inputEmail setValue:[VIColor whiteVIColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_inputPass setValue:[VIColor whiteVIColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_inputConfirmPass setValue:[VIColor whiteVIColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_inputCity setValue:[VIColor whiteVIColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //Verificar Se tem camera
    
    [self roundImage];
    
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        
//        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Erro"
//                                                              message:@"Sem camera"
//                                                             delegate:nil
//                                                    cancelButtonTitle:@"OK"
//                                                    otherButtonTitles: nil];
//        
//        [myAlertView show];
//        
//    }
//    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) voltar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) registerUser
{
    NSLog(@"Oi");
    if ([self canCreateUser]) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //[_activityIndicator startAnimating];
        //---------------------------------
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //Call your function or whatever work that needs to be done
            //Code in this part is run on a background thread
            VIServer *server = [[VIServer alloc]init];
            VIResponse *response = [server registerWithEmail:self.email andPassword:self.pass andFacebookID:nil andName:self.name andCity:self.city andBirthday:self.birthday andGender:self.gender];
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                //Stop your activity indicator or anything else with the GUI
                //Code here is run on the main thread
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                //            [_activityIndicator stopAnimating];
                
                if (response.status == VIRequestSuccess) {
                    VIUser *user = [[VIUser alloc]initWithName:self.name andEmail:self.email andGender:self.gender andBirthday:self.birthday andCity:self.city andPass:self.pass andImage:nil];
                    [[VIStorage sharedStorage]setUser:user];
                    [VIInitControl goToMainApp];
                }
                
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Erro" message:@"Tente novamente mais tarde" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                }
            });
        });
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Erro" message:@"Existem dados a serem preenchidos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

    

}

- (BOOL) verifyPass {
    if ([self.pass isEqualToString:self.confirmPass]) {
        return NO;
    }
    
    return YES;
}


-(BOOL)canCreateUser{
    self.name = self.inputName.text;
    self.birthday = self.inputBirthday.text;
    self.city = self.inputCity.text;
    self.email = self.inputEmail.text;
    self.pass = self.inputPass.text;
    self.confirmPass = self.inputConfirmPass.text;
    
    if ([self.name  isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Nome deve ser preenchido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else if ([self.birthday  isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Data de nascimento deve ser preenchido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    } else if ([self.city  isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Cidade deve ser preenchida" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    } else if ([self.email  isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Email deve ser preenchido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    } else if ([self.pass  isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Senha deve ser preenchida" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else if ([self.confirmPass  isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Confirmar deve ser  preenchida" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else if ([self verifyPass]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Senhas não conferem" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 1) {
        [self.inputBirthday becomeFirstResponder];
    } else if (textField.tag == 2) {
        [self.inputCity becomeFirstResponder];
    } else if (textField.tag == 3) {
        [self.inputEmail becomeFirstResponder];
    } else if (textField.tag == 4) {
        [self.inputPass becomeFirstResponder];
    } else if (textField.tag == 5) {
        [self.inputConfirmPass becomeFirstResponder];
    } else if (textField.tag == 6) {
        [_inputConfirmPass resignFirstResponder];
        [self canCreateUser];
    }
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.30 animations:^{
        self.view.frame = CGRectMake(0, -200, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.30 animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_inputName endEditing:YES];
    [_inputBirthday endEditing:YES];
    [_inputCity endEditing:YES];
    [_inputEmail endEditing:YES];
    [_inputPass endEditing:YES];
    [_inputConfirmPass endEditing:YES];

    [super touchesBegan:touches withEvent:event];
}

- (IBAction)changeGender:(id)sender {
    
    switch (self.genderSC.selectedSegmentIndex)
    {
        case 0:
            self.gender = @"M";
            break;
        case 1:
            self.gender = @"F";
            break;
        default:
            break;
    }
}

- (void) roundImage {
    self.photo.layer.cornerRadius = self.photo.frame.size.width / 2;
    self.photo.clipsToBounds = YES;
}


- (IBAction)changePhoto:(id)sender {
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Tirar Foto",
                            @"Escolher Foto Existente",
                            nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];

}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self takePhoto];
                    break;
                case 1:
                    [self choosePhoto];
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

- (void) takePhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void) choosePhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}




#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.photo.image = chosenImage;
    [self roundImage];
    self.background.image = self.photo.image;
    
    //todo blur background photo (Coloquei uma transparencia enquanto isso)
    [self blurPhotoBackground];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 15.0f;
    return 32.0f;
}

- (NSString*) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    } else {
        
    }
    
    return nil;
}

- (void) blurPhotoBackground {
    [self.background setAlpha:0.7f];

}

@end
