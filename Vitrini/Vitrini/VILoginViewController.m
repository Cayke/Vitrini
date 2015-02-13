//
//  VILoginViewController.m
//  Vitrini
//
//  Created by Cayke Prudente on 20/01/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VILoginViewController.h"
#import "VIRegisterViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface VILoginViewController ()

@end

@implementation VILoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //------------------ efeitos visuais
    //deixar os textfields transparentes
    [_textFieldEmail setBackgroundColor:[UIColor clearColor]];
    [_textFieldSenha setBackgroundColor:[UIColor clearColor]];
    
    //colocar blur effect no textfield email
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [blurEffectView setFrame:_textFieldEmail.bounds];
    
    //colocar vibrancy effect
    UIVibrancyEffect * vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc]initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:_textFieldEmail.bounds];
    
    [blurEffectView addSubview:vibrancyEffectView];
    
    //arredondar as bordas
    blurEffectView.layer.cornerRadius = 5;
    blurEffectView.layer.masksToBounds= YES;
    
    //adicionar o blur ao textfield
    [_textFieldEmail addSubview:blurEffectView];
    
    //colocar blur effect no textfield senha
    UIVisualEffectView *blurEffectView2 = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [blurEffectView2 setFrame:_textFieldSenha.bounds];
    
    //colocar vibrancy effect
    UIVisualEffectView *vibrancyEffectView2 = [[UIVisualEffectView alloc]initWithEffect:vibrancyEffect];
    [vibrancyEffectView2 setFrame:_textFieldSenha.bounds];
    
    [blurEffectView2 addSubview:vibrancyEffectView2];
    
    //arredondar as bordas
    blurEffectView2.layer.cornerRadius = 5;
    blurEffectView2.layer.masksToBounds= YES;
    
    //adicionar o blur ao textfield
    [_textFieldSenha addSubview:blurEffectView2];
    
    //criar os gestures recognizer para quando clicar na tela fazer o que deve
    UITapGestureRecognizer *tapEmail = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEmail)];
    tapEmail.delaysTouchesBegan = YES;
    tapEmail.numberOfTapsRequired = 1;
    [_textFieldEmail addGestureRecognizer:tapEmail];
    
    UITapGestureRecognizer *tapSenha = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSenha)];
    tapSenha.delaysTouchesBegan = YES;
    tapSenha.numberOfTapsRequired = 1;
    [_textFieldSenha addGestureRecognizer:tapSenha];
    
    _textFieldEmail.alpha = 0.95;
    _textFieldSenha.alpha = 0.95;
    
    //editar constraint para de acordo com iphone
    if (self.view.frame.size.height <600) {
        _constraintVerticalSpaceLoginFB.constant = 10;
    }
    else
    {
        _constraintVerticalSpaceLoginFB.constant= 35;
    }
    
    
    // ------------- fim efeitos visuais
    
    [_buttonLogFace addTarget:self action:@selector(tapFacebook) forControlEvents:UIControlEventTouchUpInside];
    [_buttonLogNewAcc addTarget:self action:@selector(tapPlus) forControlEvents:UIControlEventTouchUpInside];
    
    //---------- delegates
    _textFieldSenha.delegate = self;
    _textFieldEmail.delegate = self;
    //---------- fim delegates
    
                                                                                                                                                                                        
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void) tapSenha
{
    NSLog(@"tap senha");
    [_textFieldSenha becomeFirstResponder];
}

-(void) tapEmail
{
    NSLog(@"tap email");
    [_textFieldEmail becomeFirstResponder];
}

-(void) tapPlus
{
    NSLog(@"tap plus");
    
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"VILoginStoryboard" bundle:nil];
    VIRegisterViewController *registerVC = (VIRegisterViewController *) [loginStoryboard instantiateViewControllerWithIdentifier:@"Register"];
    [self presentViewController:registerVC animated:YES completion:nil];
    
    
}

-(void) tapFacebook
{
    NSLog(@"tap facebook");
    
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"email", @"user_likes",@"user_birthday", @"user_location"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             [self sessionStateChanged:session state:state error:error];
         }];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _textFieldEmail) {
        [_textFieldSenha becomeFirstResponder];
    }
    else
    {
        [_textFieldSenha resignFirstResponder];
        [self login];
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
    [_textFieldEmail resignFirstResponder];
    [_textFieldSenha resignFirstResponder];
}


//funcao para efetuar login no servidor
-(void) login
{
    //***********************************************
    //aqui botamos as coisas na tela
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //------- botar alerta com carregando
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Carregando..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.color = [UIColor redColor];
    [indicator startAnimating];
    [alertView setValue:indicator forKey:@"accessoryView"];
    [alertView show];
    //---------------------------------
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Call your function or whatever work that needs to be done
        //Code in this part is run on a background thread
        sleep(5);
        
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            //Stop your activity indicator or anything else with the GUI
            //Code here is run on the main thread
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
            //tratar algo se precisar
            [_initiControl goToMainApp];
            
        });
    });
    //****************************************************
}

//funcao para tratar sessao do facebook
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        [self userLoggedIn];
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            [self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                [self showMessage:alertText withTitle:alertTitle];
                
                // Here we will handle all other errors with a generic error message.
                // We recommend you check our Handling Errors guide for more information
                // https://developers.facebook.com/docs/ios/errors/
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                [self showMessage:alertText withTitle:alertTitle];
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
}

-(void) userLoggedIn
{
    [self getInfo];
    [self getLikes];
    
    [self.initiControl goToMainApp];
}

-(void) userLoggedOut
{
    NSLog(@"deslogou");
}

-(void) showMessage:(NSString *)alertText withTitle:(NSString *)alertTitle{
    UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:alertTitle message:alertText delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alerta show];
    
}

-(void) getInfo
{
    [FBRequestConnection startWithGraphPath:@"/me"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              NSDictionary  *result,
                                              NSError *error
                                              ) {
                              /* handle the result */
                              
                              _fbName = [result objectForKey:@"name"];
                              _fbId = [result objectForKey:@"id"];
                              _fbEmail = [result objectForKey:@"email"];
                              _fbBirthday = [result objectForKey:@"birthday"];
                              _fbCidade = [[result objectForKey:@"location"] objectForKey:@"name"];
                              _fbGender = [result objectForKey:@"gender"];
                              
                          }];
}

-(void) getLikes
{
    [FBRequestConnection startWithGraphPath:@"/me/likes"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              NSDictionary *result,
                                              NSError *error
                                              ) {
                              /* handle the result */
                              
                              dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                  //Call your function or whatever work that needs to be done
                                  //Code in this part is run on a background thread
                                  [self seeIfThereIsMoreLikes:result];
                                  
                                  
                                  dispatch_async(dispatch_get_main_queue(), ^(void) {
                                      //Stop your activity indicator or anything else with the GUI
                                      //Code here is run on the main thread
                                      NSLog(@"pegou todos os likes");
                                      //tratar algo se precisar
                                      //enviar os likes para o servidor
                                      
                                  });
                              });
                              //****************************************************
                          }];
    
}

-(void) analyzeUserLikes:(NSArray *) arrayWithLikesData
{
    //get likes from categorys Clothing and Jewelry/watches
    for (NSDictionary *dic in arrayWithLikesData) {
        if ([[dic objectForKey:@"category"] isEqualToString:@"Clothing"] || [[dic objectForKey:@"category"] isEqualToString:@"Jewelry/watches"]) {
            NSLog(@"%@", [dic objectForKey:@"name"]);
            //TODO
            //salvar os que achou e mandar pro servidor
        }
    }
    
    
    
}

-(void) seeIfThereIsMoreLikes:(NSDictionary *) result
{
    //analisar os likes desse result
    NSArray *arrayWithLikesData = [result objectForKey:@"data"];
    [self analyzeUserLikes:arrayWithLikesData];
    
    //ver se tem mais likes... se tiver faz tudo de novo
    NSDictionary *dicPaging = [result objectForKey:@"paging"];
    NSString *nextPage = [dicPaging objectForKey:@"next"];
    
    if (nextPage)
    {
        //criar novo dicionario e chamar essa funcao novamente
        NSURL *url = [[NSURL alloc]initWithString:nextPage];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        [request setURL:url];
        [request setTimeoutInterval:30];
        
        NSURLResponse *response;
        NSError *error;
        
        NSData *dataFromConnection = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        
        if (!error && dataFromConnection) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dataFromConnection options:0 error:&error];
            if (!error) {
                [self seeIfThereIsMoreLikes:dic];
            }
        }
        
        
    }
}

@end
