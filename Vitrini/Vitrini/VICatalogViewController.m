//
//  VICatalogViewController.m
//  Vitrini
//
//  Created by Cayke Prudente on 21/01/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VICatalogViewController.h"
#import "VICatalogTableViewCell.h"

@interface VICatalogViewController ()

@end

@implementation VICatalogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView.backgroundColor = [UIColor clearColor];
    
    //colocar blur effect na imagem
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [blurEffectView setFrame:self.view.frame];
    
    //colocar vibrancy effect
    UIVibrancyEffect * vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc]initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:self.view.frame];
    
    [blurEffectView addSubview:vibrancyEffectView];
    
    //adicionar o blur a view
    [_imageViewBackground addSubview:blurEffectView];
    
    //delegate table view
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //inicializar array com categorias
    [self initCategorysArray];
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
    return [UIImage imageNamed:@"Vitrini_catalogos_icon"];
}

-(NSString *)itemMenuTitle
{
    return @"Catálogo";
}

-(void) initCategorysArray
{
    //TODO
    //pegar esses dados do servidor
    _arrayCategorys = [[NSArray alloc]initWithObjects:@"Sapatos",@"Calcas", @"Vestidos", @"Saias", nil];
    _arrayWithImages = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"catalogo_temp"],[UIImage imageNamed:@"catalogo_temp"], [UIImage imageNamed:@"catalogo_temp"], [UIImage imageNamed:@"catalogo_temp"], nil];}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrayCategorys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VICatalogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VICatalogTableViewCell"];
    cell.iconImageView.image = [_arrayWithImages objectAtIndex:indexPath.row];
    cell.labelName.text = [_arrayCategorys objectAtIndex:indexPath.row];
    
    return cell;
}



@end
