//
//  VIRegisterTableViewController.m
//  Vitrini
//
//  Created by Willian Pinho on 3/13/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIRegisterTableViewController.h"
#import "VIColor.h"
#import "VIServer.h"
#import "VIStorage.h"
#import "VIInitControl.h"

@interface VIRegisterTableViewController ()

@end

@implementation VIRegisterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIView *status = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    status.backgroundColor = [VIColor whiteVIColor];
    
    [self.view addSubview:status];
    
    //colocar botar para voltar na navigation bar
    //todo arrumar esse voltar (botar design correto e tal)
    UIBarButtonItem *voltar = [[UIBarButtonItem alloc]initWithTitle:@"< Voltar" style:UIBarButtonItemStylePlain target:self action:@selector(voltar)];
    [voltar setTintColor:[VIColor whiteVIColor]];
    self.navigationItem.leftBarButtonItem = voltar;
    
    UIBarButtonItem *createButton = [[UIBarButtonItem alloc]initWithTitle:@"Criar" style:UIBarButtonItemStylePlain target:self action:@selector(registerUser)];
    self.navigationItem.rightBarButtonItem = createButton;
    
    self.navigationController.navigationBar.backgroundColor = [VIColor blueVIColor];
    
    self.navigationItem.title = @"Criar Conta";
        
    //Create
    
    createButton.tintColor = [UIColor whiteColor];
    
    
    //Deixar Table View Transparente
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //delegates
    _inputName.delegate = self;
    _inputGender.delegate = self;
    _inputBirthday.delegate = self;
    _inputEmail.delegate = self;
    _inputPass.delegate = self;
    _inputConfirmPass.delegate = self;
    _inputCity.delegate = self;
    
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

- (BOOL) verifyPass {
    if (![self.pass isEqualToString:self.confirmPass]) {
        return NO;
    }
    
    
    return YES;
}


-(BOOL)canCreateUser{
    self.name = self.inputName.text;
    self.gender = self.inputGender.text;
    self.birthday = self.inputBirthday.text;
    self.city = self.inputCity.text;
    self.email = self.inputEmail.text;
    self.pass = self.inputPass.text;
    self.confirmPass = self.inputConfirmPass.text;
    
    if (![self.name  isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Nome não preenchido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return YES;
    } else if (![self.email  isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Email não preenchido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return YES;
        
    } else if (![self.gender  isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Gênero não preenchido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return YES;
        
    } else if (![self.birthday  isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Data de nascimento não preenchido" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return YES;
        
    } else if (![self.city  isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:@"Cidade não preenchida" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return YES;
        
    } else if (![self.pass  isEqualToString: @""]) {
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 1) {
        [self.inputGender becomeFirstResponder];
    } else if (textField.tag == 2) {
        [self.inputBirthday becomeFirstResponder];
    } else if (textField.tag == 3) {
        [self.inputCity becomeFirstResponder];
    } else if (textField.tag == 4) {
        [self.inputEmail becomeFirstResponder];
    } else if (textField.tag == 5) {
        [self.inputPass becomeFirstResponder];
    } else if (textField.tag == 6) {
        [self.inputConfirmPass becomeFirstResponder];
    } else if (textField.tag == 7) {
        [_inputConfirmPass resignFirstResponder];
        [self canCreateUser];

    }
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.30 animations:^{
        self.view.frame = CGRectMake(0, -120, self.view.frame.size.width, self.view.frame.size.height);
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
    [_inputGender endEditing:YES];
    [_inputBirthday endEditing:YES];
    [_inputCity endEditing:YES];
    [_inputEmail endEditing:YES];
    [_inputPass endEditing:YES];
    [_inputConfirmPass endEditing:YES];

    [super touchesBegan:touches withEvent:event];
}







//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 1;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
