//
//  VIProfileViewController.m
//  Vitrini
//
//  Created by Cayke Prudente on 04/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIProfileViewController.h"
#import "VIProfileTableViewCell.h"
#import "VIUser.h"
#import "VIStorage.h"
#import "VIInitControl.h"

@interface VIProfileViewController ()

@end

@implementation VIProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setVariableConstraints];
    [self designPhotos];
    [self setRows];
    
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

-(UIImage *)itemMenuIcon
{
    return [UIImage imageNamed:@"Vitrini_Config_icon"];
}

-(NSString *)itemMenuTitle
{
    return @"Perfil";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VIProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell"];
    cell.labelText.text = [_rowsTableView objectAtIndex:indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_rowsTableView count];
}

-(void) designPhotos
{
    VIUser *user = [[VIStorage sharedStorage]getUser];
    _photoImageView.image = [UIImage imageWithData:user.image];
    _backgroundImageView.image = [UIImage imageWithData:user.image];
    
    //botar foto redonda
    _photoImageView.layer.cornerRadius = self.view.frame.size.height * 0.17/2;
    _photoImageView.clipsToBounds = YES;
    
    //colocar blur effect na background
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [blurEffectView setFrame:self.view.frame];
    
    //colocar vibrancy effect
    UIVibrancyEffect * vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc]initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:self.view.frame];
    
    [blurEffectView addSubview:vibrancyEffectView];
    
    //adicionar o blur a view
    [_backgroundImageView addSubview:blurEffectView];
    
    //botar nome da pessoa
    _labelName.text = user.name;
    
}

-(void) setVariableConstraints
{
    //0.3 constante de proporcao da foto de fundo
    //0.17 constante de proporcao da foto menor(redonda)
    _heightBackground.constant = self.view.frame.size.height * 0.3;
    _heightPhoto.constant = self.view.frame.size.height * 0.17;
    _widthPhoto.constant = self.view.frame.size.height * 0.17;
    
    //para achar centro de alinhamento vertical da foto redonda devemos
    //1. achar centro da foto
    //2. subtrair o valor 1. somar meio height da foto
    float centerPhoto = 20 + self.view.frame.size.height * 0.3 / 2;
    _verticalAligmentPhoto.constant = -centerPhoto;
}

-(void) setRows{
    _rowsTableView = [[NSArray alloc]initWithObjects:@"Teste", @"aqui vem algo", @"hueee", nil];
}

- (IBAction)logOut:(id)sender {
//    UIActionSheet *ac = [[UIActionSheet alloc]initWithTitle:@"Tem certeza que deseja sair?" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Sair", nil];
//    [ac showFromTabBar:self.tabBarController.tabBar];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Tem certeza que deseja sair?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *logout = [UIAlertAction actionWithTitle:@"Sair" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self logOut];
    }];
    [actionSheet addAction:logout];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:nil];
    [actionSheet addAction:cancel];
    
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

-(void) logOut;
{
    //apagar user do Storage e da plist
    [[VIStorage sharedStorage]logOutUser];
}
@end
