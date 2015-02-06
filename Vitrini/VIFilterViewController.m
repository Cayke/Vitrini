//
//  VIFilterViewController.m
//  Vitrini
//
//  Created by Cayke Prudente on 05/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIFilterViewController.h"
#import "VIColor.h"
#import "VIFilterCollectionViewCell.h"
#import "VIFilterCollectionFooterCollectionReusableView.h"

@interface VIFilterViewController ()

@end

@implementation VIFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getCategories];
    
    //criar o botao do filtro
    CGFloat width = self.view.frame.size.width;
    CGFloat dimension = 78;
    
    UIView *filter = [[UIView alloc]initWithFrame:CGRectMake(width/2 - dimension/2, -(dimension/2)+10, dimension, dimension)];
    filter.backgroundColor = [VIColor redVIColor];
    // deixar circular
    [filter.layer setCornerRadius:(dimension/2)];
    filter.layer.masksToBounds = NO;
    [self.view addSubview:filter];
    //adicionar gesure recognizer na view
    UITapGestureRecognizer *singleTapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(filterTapDetected)];
    singleTapView.numberOfTapsRequired = 1;
    [filter setUserInteractionEnabled:YES];
    [filter addGestureRecognizer:singleTapView];
    
    // status
    UIView *status = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    status.backgroundColor = [VIColor whiteViColor];
    
    [self.view addSubview:status];
    
//    _tableView.backgroundColor = [UIColor clearColor];
//    
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
    [_backgroundImageView addSubview:blurEffectView];
    
    self.view.backgroundColor = [UIColor clearColor];

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

-(void) getCategories
{
    _arrayWithCategories = [[NSMutableArray alloc]init];
    NSMutableDictionary *dict;
    
    //add coluna nova
    dict = [[NSMutableDictionary alloc]init];
    [dict setValue:@"Um" forKey:@"category"];
    [dict setValue:[NSNumber numberWithBool:YES] forKey:@"Active"];
    [_arrayWithCategories addObject:dict];
    
    //add coluna nova
    dict = [[NSMutableDictionary alloc]init];
    [dict setValue:@"Dois" forKey:@"category"];
    [dict setValue:[NSNumber numberWithBool:YES] forKey:@"Active"];
    [_arrayWithCategories addObject:dict];
    
    //add coluna nova
    dict = [[NSMutableDictionary alloc]init];
    [dict setValue:@"Tres" forKey:@"category"];
    [dict setValue:[NSNumber numberWithBool:YES] forKey:@"Active"];
    [_arrayWithCategories addObject:dict];
    
    //add coluna nova
    dict = [[NSMutableDictionary alloc]init];
    [dict setValue:@"Quatro" forKey:@"category"];
    [dict setValue:[NSNumber numberWithBool:YES] forKey:@"Active"];
    [_arrayWithCategories addObject:dict];
    
    //add coluna nova
    dict = [[NSMutableDictionary alloc]init];
    [dict setValue:@"Cinco" forKey:@"category"];
    [dict setValue:[NSNumber numberWithBool:YES] forKey:@"Active"];
    [_arrayWithCategories addObject:dict];
    
    //add coluna nova
    dict = [[NSMutableDictionary alloc]init];
    [dict setValue:@"Seis" forKey:@"category"];
    [dict setValue:[NSNumber numberWithBool:YES] forKey:@"Active"];
    [_arrayWithCategories addObject:dict];
    
}

-(void) filterTapDetected
{
    //fade view
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionFade;
    
    [[[[self view]window]layer] addAnimation:transition forKey:kCATransitionFade];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_arrayWithCategories count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VIFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Filter" forIndexPath:indexPath];
    NSDictionary *dic = [_arrayWithCategories objectAtIndex:indexPath.row];
    [cell mountWithPosition:indexPath.row];
    cell.labelName.text = [dic objectForKey:@"category"];
    if ([[dic objectForKey:@"Active"]boolValue] == NO) {
        cell.photoOnOff.image = nil;
    }
    else{
        cell.photoOnOff.image = [UIImage imageNamed:@"Icom_marcacao_filtro"];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_arrayWithCategories objectAtIndex:indexPath.row];
    [dic setValue:[NSNumber numberWithBool:![[dic valueForKey:@"Active"]boolValue]] forKey:@"Active"];
    [_arrayWithCategories replaceObjectAtIndex:indexPath.row withObject:dic];
    [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    
    NSLog(@"row:%ld", (long)indexPath.row);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionFooter) {
        VIFilterCollectionFooterCollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];
        return footer;
    }
    return nil;
}





@end
