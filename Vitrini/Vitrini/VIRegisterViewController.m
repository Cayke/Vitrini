//
//  VIRegisterViewController.m
//  Vitrini
//
//  Created by Cayke Prudente on 20/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIRegisterViewController.h"
#import "VIColor.h"
#import "VIPhotoTableViewCell.h"
#import "ViSegControlTableViewCell.h"
#import "VIImageAndLabelTableViewCell.h"
#import "VIServer.h"
#import "VIResponse.h"
#import "VIUser.h"
#import "VIStorage.h"
#import "VIInitControl.h"

@interface VIRegisterViewController ()

@property (nonatomic) NSInteger gender;

//textFields (referencia)
@property (weak, nonatomic) UITextField *nameTF;
@property (weak, nonatomic) UITextField *dateTF;
@property (weak, nonatomic) UITextField *cityTF;
@property (weak, nonatomic) UITextField *emailTF;
@property (weak, nonatomic) UITextField *passTF;
@property (weak, nonatomic) UITextField *confirmPassTF;

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *date;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *pass;
@property (nonatomic) NSString *confirmPass;
@property (nonatomic) NSData *image;

@end

@implementation VIRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //colocar botoes na navigation bar
    //botao voltar
    UIBarButtonItem *voltar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"VIStoreProfileNavigationBarBackButton.png"] style:UIBarButtonItemStylePlain target:self action:@selector(voltar)];
    [voltar setTintColor:[VIColor whiteVIColor]];
    self.navigationItem.leftBarButtonItem = voltar;
    
    //botao finalizar
    UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithTitle:@"Criar" style:UIBarButtonItemStyleDone target:self action:@selector(doneSelected)];
    [done setTintColor:[VIColor whiteVIColor]];
    self.navigationItem.rightBarButtonItem = done;
    
    //title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [VIColor whiteVIColor];
    self.navigationItem.titleView = label;
    label.text = @"Criar Conta";
    [label sizeToFit];
    
    
    self.customNavBar.items = [NSArray arrayWithObject:self.navigationItem];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-1.0f, 0.0f, 0.0f, 0.0);
    
    //variaveis de controle
    _gender = -1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) voltar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) doneSelected
{
    //request com server se todos os campos preenchidos
    if ([self registerCompleted]) {
        
        //cadastrar
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Carregando..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator.color = [VIColor blueVIColor];
        [indicator startAnimating];
        [alertView setValue:indicator forKey:@"accessoryView"];
        [alertView show];
        //---------------------------------
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //Call your function or whatever work that needs to be done
            //Code in this part is run on a background thread
            
            //tratar gender
            NSString *gender;
            if (self.gender == 0) {
                gender = @"M";
            }
            else
            {
                gender = @"F";
            }
            
            VIServer *server = [[VIServer alloc]init];
            VIResponse *response = [server registerWithEmail:self.email andPassword:self.pass andFacebookID:nil andName:self.name andCity:self.city andBirthday:self.date andGender:gender];
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                //Stop your activity indicator or anything else with the GUI
                //Code here is run on the main thread
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [alertView dismissWithClickedButtonIndex:0 animated:YES];

                
                if (response.status == VIRequestSuccess) {
                    VIUser *user = [[VIUser alloc]initWithName:self.name andEmail:self.email andGender:gender andBirthday:self.date andCity:self.city andPass:self.pass andImage:_image];
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

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        VIPhotoTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"VIPhotoTableViewCell"];
        
        if (_image) {
            [cell mountWithImage:_image];
        }

        
        return cell;
    }
    else if (indexPath.section == 1) {
        ViSegControlTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"ViSegControlTableViewCell"];
        
        cell.segControl.selectedSegmentIndex = _gender;
        [cell.segControl addTarget:self action:@selector(segmentControlChangeState:) forControlEvents:UIControlEventValueChanged];
        
        return cell;
    }
    else if (indexPath.section == 2) {
        VIImageAndLabelTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"VIImageAndLabelTableViewCell"];
        cell.textField.delegate = self;
        cell.textField.secureTextEntry = NO;
        
        if (indexPath.row == 0) {
            [cell mountWithPosition:0];
            _nameTF = cell.textField;
        }
        if (indexPath.row == 1) {
            [cell mountWithPosition:1];
            _dateTF = cell.textField;
        }
        if (indexPath.row == 2) {
            [cell mountWithPosition:2];
            _cityTF = cell.textField;
        }
        
        return cell;
    }
    else if (indexPath.section == 3) {
        VIImageAndLabelTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"VIImageAndLabelTableViewCell"];
        cell.textField.delegate = self;
        
        if (indexPath.row == 0) {
            [cell mountWithPosition:3];
            _emailTF = cell.textField;
            cell.textField.secureTextEntry = NO;
        }
        if (indexPath.row == 1) {
            [cell mountWithPosition:4];
            _passTF = cell.textField;
                    cell.textField.secureTextEntry = YES;
        }
        if (indexPath.row == 2) {
            [cell mountWithPosition:5];
            _confirmPassTF = cell.textField;
                    cell.textField.secureTextEntry = YES;
        }
        
        return cell;
    }
    
    return nil;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return indexPath;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self tapPhoto];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 1;
    }
    else if (section == 2 || section == 3)
    {
        return 3;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 190;
    }
    
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 32;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(void) segmentControlChangeState:(id)sender
{
    UISegmentedControl *segControl = sender;
    _gender = segControl.selectedSegmentIndex;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 250, 0);
    
    if (textField == _nameTF) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
        [self.tableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:NO];
    }
    else if (textField == _dateTF) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:2];
        [self.tableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
    }
    else if (textField == _cityTF) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:2];
        [self.tableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
    }
    else if (textField == _emailTF) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
        [self.tableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
    }
    else if (textField == _passTF) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:3];
        [self.tableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
    }
    else if (textField == _confirmPassTF) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:3];
        [self.tableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _nameTF) {
        _name = _nameTF.text;
    }
    else if (textField == _dateTF)
    {
        _date = _dateTF.text;
    }
    else if (textField == _cityTF)
    {
        _city = _cityTF.text;
    }
    
    else if (textField == _emailTF)
    {
        _email = _emailTF.text;
    }
    else if (textField == _passTF)
    {
        _pass = _passTF.text;
    }
    else if (textField == _confirmPassTF) {
        _confirmPass = _confirmPassTF.text;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _nameTF) {
        [_dateTF becomeFirstResponder];
    }
    else if (textField == _dateTF)
    {
        [_cityTF becomeFirstResponder];
    }
    else if (textField == _cityTF)
    {
        [_emailTF becomeFirstResponder];
    }
    
    else if (textField == _emailTF)
    {
        [_passTF becomeFirstResponder];
    }
    else if (textField == _passTF)
    {
        [_confirmPassTF becomeFirstResponder];
    }
    else if (textField == _confirmPassTF) {
        [textField resignFirstResponder];
        _tableView.contentInset = UIEdgeInsetsMake(-1, 0, 0, 0);
        [self doneSelected];
    }
    
    return YES;
}

-(BOOL) registerCompleted
{
    if (!_image || _gender == -1 || !_name || !_date || !_city || !_email || !_pass || (![_pass isEqualToString:_confirmPass])) {
        return NO;
    }
    return YES;
}

-(void) tapPhoto
{
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.image = UIImagePNGRepresentation(chosenImage);

    [self.tableView reloadData];

    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


@end