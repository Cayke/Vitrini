//
//  VIRegisterViewController.m
//  Vitrini
//
//  Created by Cayke Prudente on 20/01/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIRegisterViewController.h"
#import "VIColor.h"
#import "VIServer.h"
#import "VIInitControl.h"
#import "VIResponse.h"
#import "VIUser.h"
#import "VIStorage.h"

@interface VIRegisterViewController ()

@end

@implementation VIRegisterViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstFieldsOfSection = [NSArray arrayWithObjects:
                                 @"name",
                                 @"city",
                                 @"gender",
                                 @"birthday", nil];
    self.secondFieldsOfSection = [NSArray arrayWithObjects:
                                  @"email",
                                  @"pass",
                                  @"confirmPass", nil];
    self.sectionPhoto = [NSArray arrayWithObjects:@"photo", nil];
    self.arrayOfSections = [NSArray arrayWithObjects:self.sectionPhoto,self.firstFieldsOfSection,self.secondFieldsOfSection, nil];
    
    // status
    UIView *status = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    status.backgroundColor = [VIColor whiteVIColor];
    
    [self.view addSubview:status];
    
    //colocar botar para voltar na navigation bar
    //todo arrumar esse voltar (botar design correto e tal)
    UIBarButtonItem *voltar = [[UIBarButtonItem alloc]initWithTitle:@"< Voltar" style:UIBarButtonItemStylePlain target:self action:@selector(voltar)];
    [voltar setTintColor:[VIColor whiteVIColor]];
    self.navigationItem.leftBarButtonItem = voltar;
    
    UIBarButtonItem *createButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Create", nil) style:UIBarButtonItemStylePlain target:self action:@selector(registerUser)];
    self.navigationItem.rightBarButtonItem = createButton;
    
    self.navigationItem.title = @"Criar Conta";
    
    self.navigationBar.items = [NSArray arrayWithObject:self.navigationItem];
    
    //Create

    createButton.tintColor = [UIColor whiteColor];
    
    
    //Deixar Table View Transparente
    self.tableView.backgroundColor = [UIColor clearColor];

    //arredondar a imageview
//    _imageView.layer.cornerRadius = _imageView.bounds.size.width/2;
//    _imageView.clipsToBounds = YES;
//    _imageView.layer.masksToBounds = YES;
//    _imageView.backgroundColor = [UIColor clearColor];
//    _imageView.layer.borderWidth = 5;
//    _imageView.layer.borderColor = [VIColor whiteVIColor].CGColor;
    
    //adicionar gesture na imageview
//    UITapGestureRecognizer *singleTapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewTap)];
//    singleTapView.numberOfTapsRequired = 1;
//    [_imageView setUserInteractionEnabled:YES];
//    [_imageView addGestureRecognizer:singleTapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) voltar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//-(void) imgViewTap
//{
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancelar", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Tirar Foto", nil),NSLocalizedString(@"Escolher Existente", nil), nil];
//    [actionSheet showInView:self.view];
//}

//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    BOOL showImagePicker = NO;
//    if (buttonIndex != actionSheet.cancelButtonIndex)
//    {
//        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
//        if (buttonIndex == 0) // tirar foto
//        {
//            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//                showImagePicker = YES;
//            }
//            else
//            {
//                UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Ops" message:@"Seu device nao suporta esta opcao" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                [alerta show];
//            }
//        }
//        else if (buttonIndex == 1)
//        {
//            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//            showImagePicker = YES;
//        }
//        
//        if (showImagePicker) {
//            
//            
//            imagePicker.delegate = self;
//            
//            //habilita edicaoUIips
//            imagePicker.allowsEditing = YES;
//            
//            [self presentViewController:imagePicker animated:YES completion:nil];
//        }
//    }
//}

//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    UIImage *imagem = info[UIImagePickerControllerEditedImage];
//    
//    self.imageView.image = imagem;
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

-(void) registerUser
{
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
                VIUser *user = [[VIUser alloc]initWithName:self.name andEmail:self.email andGender:self.gender andBirthday:self.birthday andCity:self.city andPass:self.pass];
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
    
    }
}


#pragma Create TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.arrayOfSections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"";
    } else {
        return @"";
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numbersOfRows = [self.arrayOfSections[section] count];
    
    return numbersOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *array = self.arrayOfSections[indexPath.section];
    NSString *item = array[indexPath.row];
    NSString *registerSingleInputCell = @"VIRegisterSingleInputTableViewCellID";
    NSString *registerPhotoInputCell = @"VIRegisterPhotoTableViewCellID";


    
    if (array == self.firstFieldsOfSection) {
        if ([item isEqualToString:@"name"]) {
            VIRegisterSingleInputTableViewCell *rsitvc = (VIRegisterSingleInputTableViewCell *)[tableView dequeueReusableCellWithIdentifier:registerSingleInputCell forIndexPath:indexPath];
            
            rsitvc.singleInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name"attributes:@{NSForegroundColorAttributeName: [VIColor darkWhiteVIColor]}];
            
            [rsitvc.singleInput sizeToFit];
            rsitvc.singleInput.tag = 1;
            
            rsitvc.icon.image = [UIImage imageNamed:@"Vitrini@2x.png"];


            rsitvc.singleInput.delegate = self;

            return rsitvc;
        } else if ([item isEqualToString:@"city"]) {
            VIRegisterSingleInputTableViewCell *rsitvc = (VIRegisterSingleInputTableViewCell *)[tableView dequeueReusableCellWithIdentifier:registerSingleInputCell forIndexPath:indexPath];
            
            rsitvc.singleInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"City"attributes:@{NSForegroundColorAttributeName: [VIColor darkWhiteVIColor]}];
            
            [rsitvc.singleInput sizeToFit];
            rsitvc.singleInput.tag = 2;

            rsitvc.singleInput.delegate = self;

            return rsitvc;
        } else if ([item isEqualToString:@"birthday"]) {
            VIRegisterSingleInputTableViewCell *rsitvc = (VIRegisterSingleInputTableViewCell *)[tableView dequeueReusableCellWithIdentifier:registerSingleInputCell forIndexPath:indexPath];
            
            rsitvc.singleInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Birthday"attributes:@{NSForegroundColorAttributeName: [VIColor darkWhiteVIColor]}];
            
            [rsitvc.singleInput sizeToFit];
            rsitvc.singleInput.tag = 3;
            rsitvc.singleInput.delegate = self;

            
            return rsitvc;
        } else if ([item isEqualToString:@"gender"]) {
            VIRegisterSingleInputTableViewCell *rsitvc = (VIRegisterSingleInputTableViewCell *)[tableView dequeueReusableCellWithIdentifier:registerSingleInputCell forIndexPath:indexPath];
            
            rsitvc.singleInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Gender"attributes:@{NSForegroundColorAttributeName: [VIColor darkWhiteVIColor]}];
            
            [rsitvc.singleInput sizeToFit];
            rsitvc.singleInput.tag = 4;
            
            rsitvc.singleInput.delegate = self;

            return rsitvc;
        }
        
        
    } else if (array == self.secondFieldsOfSection ){
        if ([item isEqualToString:@"email"]) {
            VIRegisterSingleInputTableViewCell *rsitvc = (VIRegisterSingleInputTableViewCell *)[tableView dequeueReusableCellWithIdentifier:registerSingleInputCell forIndexPath:indexPath];
            
            rsitvc.singleInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email"attributes:@{NSForegroundColorAttributeName: [VIColor darkWhiteVIColor]}];
            
            [rsitvc.singleInput sizeToFit];
            rsitvc.singleInput.tag = 5;
            
            rsitvc.singleInput.delegate = self;
            
            return rsitvc;
        } else if ([item isEqualToString:@"pass"]) {
            VIRegisterSingleInputTableViewCell *rsitvc = (VIRegisterSingleInputTableViewCell *)[tableView dequeueReusableCellWithIdentifier:registerSingleInputCell forIndexPath:indexPath];
            
            rsitvc.singleInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Senha"attributes:@{NSForegroundColorAttributeName: [VIColor darkWhiteVIColor]}];
            
            [rsitvc.singleInput sizeToFit];
            rsitvc.singleInput.tag = 6;
            
            rsitvc.singleInput.delegate = self;
            
            return rsitvc;
        } else if ([item isEqualToString:@"confirmPass"]) {
            VIRegisterSingleInputTableViewCell *rsitvc = (VIRegisterSingleInputTableViewCell *)[tableView dequeueReusableCellWithIdentifier:registerSingleInputCell forIndexPath:indexPath];
            
            rsitvc.singleInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirmar Senha"attributes:@{NSForegroundColorAttributeName: [VIColor darkWhiteVIColor]}];
            
            [rsitvc.singleInput sizeToFit];
            rsitvc.singleInput.tag = 7;
            
            rsitvc.singleInput.delegate = self;
            
            return rsitvc;
        }
    } else if (array == self.sectionPhoto ){
        if ([item isEqualToString:@"photo"]) {
            VIRegisterPhotoTableViewCell *rptvc = (VIRegisterPhotoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:registerPhotoInputCell forIndexPath:indexPath];
            
            rptvc.photoImageView.image = [UIImage imageNamed:@"Patricia-Beck.jpg"];
            rptvc.backgroundImageView.image = [UIImage imageNamed:@"Patricia-Beck.jpg"];
            
            
            
            return rptvc;
        }
    }
    
    
    UITableViewCell  *genericCell = [[UITableViewCell alloc]init];
    return genericCell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 200.0;
    } else if (indexPath.section != 0){
        return 60.0;
    }
    
    return 40.0;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        _name = textField.text;
    } else if (textField.tag == 2){
        _city = textField.text;
    } else if (textField.tag == 3){
        _birthday = textField.text;
    } else if (textField.tag == 4){
        _gender = textField.text;
    } else if (textField.tag == 5){
        _email = textField.text;
    } else if (textField.tag == 6){
       _pass = textField.text;
    } else if (textField.tag == 7){
        _confirmPass = textField.text;
    }
}



//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    if (textField == _textFieldEmail) {
//        [_textFieldSenha becomeFirstResponder];
//    }
//    else
//    {
//        [_textFieldSenha resignFirstResponder];
//        [self loginWithEmailAndPassword];
//    }
//    return YES;
//}
//
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    [UIView animateWithDuration:0.30 animations:^{
//        self.view.frame = CGRectMake(0, -120, self.view.frame.size.width, self.view.frame.size.height);
//    }];
//}
//
//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    [UIView animateWithDuration:0.30 animations:^{
//        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    }];
//}
//
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [_textFieldEmail resignFirstResponder];
//    [_textFieldSenha resignFirstResponder];
//}


- (BOOL) verifyPass {
    if (![self.pass isEqualToString:self.confirmPass]) {
        return NO;
    }
    
    
    return YES;
}


-(BOOL)canCreateUser{
    if (![self.name  isEqual: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Nome não preenchido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return YES;
    } else if (![self.email  isEqual: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Email não preenchido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return YES;

    } else if (![self.gender  isEqual: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Gênero não preenchido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return YES;

    } else if (![self.birthday  isEqual: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Data de nascimento não preenchido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return YES;

    } else if (![self.city  isEqual: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Cidade não preenchida" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return YES;

    } else if (![self.pass  isEqual: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Senha não preenchida" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return YES;
    } else if (![self verifyPass]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Senhas não conferem" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return YES;
    }
    
    return NO;
}





@end
