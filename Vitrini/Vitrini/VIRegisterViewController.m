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

@interface VIRegisterViewController ()

@end

@implementation VIRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // status
    UIView *status = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    status.backgroundColor = [VIColor whiteVIColor];
    
    [self.view addSubview:status];
    
    //colocar botar para voltar na navigation bar
    //todo arrumar esse voltar (botar design correto e tal)
    UIBarButtonItem *voltar = [[UIBarButtonItem alloc]initWithTitle:@"< Voltar" style:UIBarButtonItemStylePlain target:self action:@selector(voltar)];
    [voltar setTintColor:[VIColor whiteVIColor]];
    self.navigationItem.leftBarButtonItem = voltar;
    self.navigationBar.items = [NSArray arrayWithObject:self.navigationItem];
    
    
    //arredondar a imageview
    _imageView.layer.cornerRadius = _imageView.bounds.size.width/2;
    _imageView.clipsToBounds = YES;
    _imageView.layer.masksToBounds = YES;
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.layer.borderWidth = 5;
    _imageView.layer.borderColor = [VIColor whiteVIColor].CGColor;
    
    //adicionar gesture na imageview
    UITapGestureRecognizer *singleTapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewTap)];
    singleTapView.numberOfTapsRequired = 1;
    [_imageView setUserInteractionEnabled:YES];
    [_imageView addGestureRecognizer:singleTapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) voltar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) imgViewTap
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancelar", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Tirar Foto", nil),NSLocalizedString(@"Escolher Existente", nil), nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL showImagePicker = NO;
    if (buttonIndex != actionSheet.cancelButtonIndex)
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        if (buttonIndex == 0) // tirar foto
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                showImagePicker = YES;
            }
            else
            {
                UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Ops" message:@"Seu device nao suporta esta opcao" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alerta show];
            }
        }
        else if (buttonIndex == 1)
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            showImagePicker = YES;
        }
        
        if (showImagePicker) {
            
            
            imagePicker.delegate = self;
            
            //habilita edicaoUIips
            imagePicker.allowsEditing = YES;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imagem = info[UIImagePickerControllerEditedImage];
    
    self.imageView.image = imagem;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) registerUser
{
//    VIServer *server = [[VIServer alloc]init];
    //todo
//    VIResponse *response = [server registerWithEmail:<#(NSString *)#> andPassword:<#(NSString *)#> andFacebookID:nil andName:<#(NSString *)#> andCity:<#(NSString *)#> andBirthday:<#(NSString *)#> andGender:<#(NSString *)#>];
//    if (response.status == VIRequestSuccess) {
//        [VIInitControl goToMainApp];
//    }
//    else
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Erro" message:@"Tente novamente mais tarde" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
//    }
}


@end
