//
//  VIMainMenu.m
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 12/16/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "VIMainMenu.h"

#define ANIMATION_TIME 0.5f

@implementation VIMainMenu

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
    NSLog(@"show menu");
    self.hidden = NO;
    [self fadeIn];
}

-(void)hideMenu{
    NSLog(@"hide menu");
    [self fadeOut];
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

-(void)mountTable{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    _table.dataSource = self;
    _table.delegate = self;
    [self addSubview:_table];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.showsVerticalScrollIndicator = NO;
    
    _table.viewForBaselineLayout.backgroundColor = [UIColor clearColor];
    
    // inicia a table view no meio
    UIEdgeInsets inset = UIEdgeInsetsMake((self.frame.size.height/4), 0, 100, 0);
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
    
    cell.textLabel.text = [self.viTabBarVC.viewControllers[indexPath.row] title];
    
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
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
