//
//  VIMainMenu.m
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 12/16/14.
//  Copyright (c) 2014 Vitrini. All rights reserved.
//

#import "VIMainMenu.h"

#define ANIMATION_TIME 0.5f
#define ANIMATION_TIME_MENU_ITEM 0.3f

@implementation VIMainMenu {
    UIImageView *menuIcon;
    UIImageView *actualVcIcon;
    
    CGRect menuIconFrame;
    CGRect menuIconFrameOut;
}

-(instancetype)init{
    @throw [NSException exceptionWithName:@"VIMenuView" reason:@"needs correct delegate" userInfo:nil];
    return nil;
}

- (instancetype)initWithVITabBarVC:(VIMainViewController*)vitabbarvc andFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _viTabBarVC = vitabbarvc;
        [self setFrame:frame];
        [self initialSetup];
    }
    return self;
}

-(void)initialSetup{
    
    self.backgroundColor = [UIColor clearColor];
    
    // blur effect
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = self.frame;
    [self addSubview:visualEffectView];
    
    
    [self setAlpha:0.0f];
    self.hidden = YES;
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self mountTable];
}

-(void)showMenu{
    self.hidden = NO;
    [self fadeIn];
    [self fadeMenuItemIn];
}

-(void)hideMenu{
    [self fadeOut];
    [self fadeMenuItemOut];
}

-(void)fadeIn{
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView animateWithDuration:ANIMATION_TIME delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.alpha = 1.0f;
        
        self.table.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
    } completion:^(BOOL finished){
        self.hidden = NO;
    }];
}

-(void)fadeOut{
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView animateWithDuration:ANIMATION_TIME delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.alpha = 0.0f;
        
        self.table.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
        
    } completion:^(BOOL finished){
        self.hidden = YES;
    }];
}

-(void)installIconsOnMenu{
    // menu icon
    CGFloat menuIconWidth, menuIconHeight;
    
    menuIconWidth = 40.0f;
    menuIconHeight = 40.0f;
    
    menuIconFrame = CGRectMake(40, 14, menuIconWidth, menuIconHeight);
    menuIconFrameOut = CGRectMake(40, 80, menuIconWidth, menuIconHeight);
    menuIcon = [[UIImageView alloc]initWithFrame:menuIconFrameOut];
    menuIcon.image = [UIImage imageNamed:@"CloseMenu.png"];
    menuIcon.alpha = 1.0;
    [self.viTabBarVC.menuView addSubview:menuIcon];
    
    [self setActualViewControllerMenuImageItem];
    [_viTabBarVC.menuView addSubview:actualVcIcon];
}

-(void)setActualViewControllerMenuImageItem{
    // menu icon
    UIViewController <VIViewControllerMenuItemProtocol> *vc = (UIViewController <VIViewControllerMenuItemProtocol> *) _viTabBarVC.selectedViewController;
    actualVcIcon = [[UIImageView alloc]initWithFrame:menuIconFrame];
    actualVcIcon.image = [vc itemMenuIcon];
}

-(void)fadeMenuItemIn{
    // substituir o item atual da viewcontroller pelo item do menu
    [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        menuIcon.alpha = 1.0f;
        actualVcIcon.alpha = 0.0f;
        
    } completion:nil];
    [UIView animateWithDuration:ANIMATION_TIME_MENU_ITEM delay:0.1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        actualVcIcon.frame = menuIconFrameOut;
        menuIcon.frame = menuIconFrame;
        
    } completion:nil];
}
-(void)fadeMenuItemOut{
    // substituir o item do menu pelo da viewcontroller
    [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        menuIcon.alpha = 0.0f;
        actualVcIcon.alpha = 1.0f;

    } completion:nil];
    [UIView animateWithDuration:ANIMATION_TIME_MENU_ITEM delay:0.1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        actualVcIcon.frame = menuIconFrame;
        menuIcon.frame = menuIconFrameOut;
        
    } completion:nil];
}

-(void)mountTable{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    _table.dataSource = self;
    _table.delegate = self;
    [self addSubview:_table];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.showsVerticalScrollIndicator = NO;
    
    _table.viewForBaselineLayout.backgroundColor = [UIColor clearColor];
    
    // inicia a table view no meio
    UIEdgeInsets inset = UIEdgeInsetsMake((self.frame.size.height/2), 0, 100, 0);
    _table.contentInset = inset;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viTabBarVC.viewControllers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
    }

    cell.textLabel.text = [self.viTabBarVC.viewControllers[indexPath.row] itemMenuTitle];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self hideMenu];
    [self.table deselectRowAtIndexPath:indexPath animated:YES];
    [self.viTabBarVC changeVCtoIndex:indexPath.row];
    [self setActualViewControllerMenuImageItem];
}

@end
