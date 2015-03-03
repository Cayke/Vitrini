//
//  VICatalogViewController.m
//  Vitrini
//
//  Created by Cayke Prudente on 21/01/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VICatalogViewController.h"
#import "VICatalogTableViewCell.h"
#import "VIResponse.h"
#import "VIServer.h"
#import "VICategory.h"

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
    _arrayCategorys = [[NSMutableArray alloc]init];
   // _arrayWithImages = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"catalogo_temp"],[UIImage imageNamed:@"catalogo_temp"], [UIImage imageNamed:@"catalogo_temp"], [UIImage imageNamed:@"catalogo_temp"], nil];

    
    //pegar esses dados do servidor
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //---------------------------------
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Call your function or whatever work that needs to be done
        //Code in this part is run on a background thread
        VIServer *server = [[VIServer alloc]init];
        VIResponse *response = [server getCategories];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            //Stop your activity indicator or anything else with the GUI
            //Code here is run on the main thread
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            //tratar algo se precisar
            if (response.status == VIRequestSuccess) {
                for (NSDictionary *dic in response.value) {
                    VICategory *category = [[VICategory alloc]initWithDicFromServer:dic];
                    [_arrayCategorys addObject:category];
                }
                //_arrayWithImages = ...
                [_tableView reloadData];
            }
            else {
                UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Erro de conexao" message:@"Conecte-se a internet e tente novamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alerta show];
            }
            
        });
    });
}

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
