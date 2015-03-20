//
//  VIProfileTableViewController.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 14/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIProfileTableViewController.h"

#import "VIColor.h"
#import "VIStorage.h"

@interface VIProfileTableViewController ()

@end

@implementation VIProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    
    UIView *auxView = [[UIView alloc]initWithFrame:self.view.frame];
    [auxView addSubview:self.view];
    self.view = auxView;
    
    VIUser *user = [VIStorage sharedStorage].user;
    if (!user) {
        @throw [NSException exceptionWithName:@"User" reason:@"Nao tem usuario aqui na tbvc" userInfo:nil];
    } else {
        _label1.text = user.name;
        _label2.text = user.email;
        _label3.text = user.birthday;
        _label4.text = user.city;
        
        if (user.image) {
            UIImage *image = [UIImage imageWithData:user.image];
            _photo.image = image;
            _backPhoto.image = image;
            
            
            UIBlurEffect *blurEffect;
            blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            UIVisualEffectView *visualEffectView;
            visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            visualEffectView.frame = CGRectMake(_layerBlurBackPhoto.frame.origin.x, _layerBlurBackPhoto.frame.origin.y, self.view.frame.size.width, _layerBlurBackPhoto.frame.size.height);
            [_layerBlurBackPhoto addSubview:visualEffectView];
            
        } else {
            _photo.hidden = YES;
        }
    }
    
    _photo.clipsToBounds = YES;
    _photo.layer.cornerRadius = 72.0f;
    
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backView.image = [UIImage imageNamed:@"viewBackground"];
    [self.view insertSubview:backView atIndex:0];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [_segmentControll setSelectedSegmentIndex:0];
    if (![[VIStorage sharedStorage].user.filterGender isEqualToString:@"M"]) {
        [_segmentControll setSelectedSegmentIndex:1];
    }
}

-(UIImage *)itemMenuIcon {
    return [UIImage imageNamed:@"iconProfile"];
}

-(NSString *)itemMenuTitle {
    return @"Perfil";
}

- (IBAction)genderChanged:(UISegmentedControl *)sender {
    if ([[VIStorage sharedStorage].user.filterGender isEqual:@"M"]) {
        [VIStorage sharedStorage].user.filterGender = @"F";
    } else {
        [VIStorage sharedStorage].user.filterGender = @"M";
    }
}
- (IBAction)pressLogout:(UIButton *)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Tem certeza que deseja sair?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *logout = [UIAlertAction actionWithTitle:@"Sair" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self logOut];
    }];
    [actionSheet addAction:logout];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:nil];
    [actionSheet addAction:cancel];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}


-(void)logOut{
    //apagar user do Storage e da plist
    [[VIStorage sharedStorage]logOutUser];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
