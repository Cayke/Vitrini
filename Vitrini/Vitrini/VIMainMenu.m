//
//  VIMainMenu.m
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 12/16/14.
//  Copyright (c) 2014 Vitrini. All rights reserved.
//

#import "VIMainMenu.h"

#define ANIMATION_TIME 0.5f
#define ANIMATION_TIME_MENU_ITEM_MOV 0.3f
#define ANIMATION_TIME_MENU_ITEM_ALPHA 0.1f
#define DELAY_MENU_ANIMATION 0.1F

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
    CGFloat superWidth = 120.0f;
    // menu icon
    CGFloat menuIconWidth, menuIconHeight;
    
    menuIconWidth = 40.0f;
    menuIconHeight = 32.0f;
    
    menuIconFrame = CGRectMake(superWidth/2-menuIconWidth/2, superWidth/4 - menuIconHeight/2 + 4, menuIconWidth, menuIconHeight);
    menuIconFrameOut = CGRectMake(superWidth/2-menuIconWidth/2, 80, menuIconWidth, menuIconHeight);
    menuIcon = [[UIImageView alloc]initWithFrame:menuIconFrameOut];
    menuIcon.image = [UIImage imageNamed:@"CloseMenu.png"];
    menuIcon.alpha = 1.0;
    
    menuIcon.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.viTabBarVC.menuView addSubview:menuIcon];
    
    actualVcIcon = [[UIImageView alloc]initWithFrame:menuIconFrame];
    [self setActualViewControllerMenuImageItem];
    
    actualVcIcon.contentMode = UIViewContentModeScaleAspectFit;
    
    [_viTabBarVC.menuView addSubview:actualVcIcon];
}

-(void)setActualViewControllerMenuImageItem{
    // menu icon
    UIViewController <VIViewControllerMenuItemProtocol> *vc = (UIViewController <VIViewControllerMenuItemProtocol> *) _viTabBarVC.selectedViewController;
    actualVcIcon.image = [vc itemMenuIcon];
}

-(void)fadeMenuItemIn{
    // substituir o item atual da viewcontroller pelo item do menu
    [UIView animateWithDuration:ANIMATION_TIME_MENU_ITEM_ALPHA delay:DELAY_MENU_ANIMATION options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        menuIcon.alpha = 1.0f;
        actualVcIcon.alpha = 0.0f;
        
    } completion:nil];
    [UIView animateWithDuration:ANIMATION_TIME_MENU_ITEM_MOV delay:DELAY_MENU_ANIMATION options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        actualVcIcon.frame = menuIconFrameOut;
        menuIcon.frame = menuIconFrame;
        
    } completion:nil];
}
-(void)fadeMenuItemOut{
    // substituir o item do menu pelo da viewcontroller
    [UIView animateWithDuration:ANIMATION_TIME_MENU_ITEM_ALPHA delay:DELAY_MENU_ANIMATION options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        menuIcon.alpha = 0.0f;
        actualVcIcon.alpha = 1.0f;

    } completion:nil];
    [UIView animateWithDuration:ANIMATION_TIME_MENU_ITEM_MOV delay:DELAY_MENU_ANIMATION options:UIViewAnimationOptionBeginFromCurrentState animations:^{
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
    UIEdgeInsets inset = UIEdgeInsetsMake((self.frame.size.height/3), 0, 100, 0);
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
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
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
