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
    
    ///Navigation Bar
    self.navigationController.navigationBar.backgroundColor = [VIColor blueVIColor];

    
    UIBarButtonItem *voltar = [[UIBarButtonItem alloc]initWithTitle:@"voltar" style:UIBarButtonItemStylePlain target:self action:@selector(voltar)];
    [voltar setTintColor:[VIColor darkWhiteVIColor]];
    self.navigationItem.leftBarButtonItem = voltar;

    UIBarButtonItem *adicionar = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                               target:self action:@selector(registerUser)];
    
    [adicionar setTintColor:[VIColor darkWhiteVIColor]];
    self.navigationItem.rightBarButtonItem = adicionar;
    
    //Title
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [VIColor darkWhiteVIColor]};
    self.navigationItem.title = @"Criar Conta";
    self.navigationController.navigationBar.items = [NSArray arrayWithObject:self.navigationItem];

    //Create
    
    
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
    
    self.genderSC = 0;
    
    
    [_inputName setValue:[VIColor darkWhiteVIColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_inputBirthday setValue:[VIColor darkWhiteVIColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_inputEmail setValue:[VIColor darkWhiteVIColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_inputPass setValue:[VIColor darkWhiteVIColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_inputConfirmPass setValue:[VIColor darkWhiteVIColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_inputCity setValue:[VIColor darkWhiteVIColor] forKeyPath:@"_placeholderLabel.textColor"];

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
@end
