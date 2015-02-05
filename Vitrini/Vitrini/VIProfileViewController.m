//
//  VIProfileViewController.m
//  Vitrini
//
//  Created by Cayke Prudente on 04/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIProfileViewController.h"
#import "VIProfileTableViewCell.h"

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
    return [UIImage imageNamed:@"Icon_feed_Menu"];
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
    _photoImageView.image = [UIImage imageNamed:@"zegatao"];
    _backgroundImageView.image = [UIImage imageNamed:@"zegatao"];
    
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
    _labelName.text = @"Cayke";
    
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

@end
