//
//  VIFeedSectionView.m
//  Vitrini
//
//  Created by Cayke Prudente on 03/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIFeedSectionView.h"
#import "VIStoreProfileViewController.h"


@implementation VIFeedSectionView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self createLayout];
    
    return self;
}

-(void) createLayout
{
    //criar botao foto loja
    UIButton *buttonStore = [[UIButton alloc]initWithFrame:CGRectMake(8, 7, 30, 30)];
    
    [self addSubview:buttonStore];
    
    //add fotinha loja
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageView.image = [UIImage imageNamed:@"profile_feed_temp"];
    //botar foto redonda
    imageView.layer.cornerRadius = imageView.frame.size.width/2;
    imageView.clipsToBounds = YES;
    
    //adicionar imageview ao button
    [buttonStore addSubview:imageView];
    [buttonStore setShowsTouchWhenHighlighted:YES];
    [buttonStore addTarget:self action:@selector(goToStorePage) forControlEvents:UIControlEventTouchUpInside];
    
    //adicionar nome da loja
    UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake(50, 12, 200, 20)];
    labelName.text = @"rivaldo";

    [self addSubview:labelName];
    
    //linha seguinte para section nao ficar "transparente"
    //self.backgroundColor = [UIColor whiteColor];

    
}

-(void) goToStorePage
{
    NSLog(@"go to store page");
    UIStoryboard *store = [UIStoryboard storyboardWithName:@"VIStoreProfile" bundle:nil];
    VIStoreProfileViewController *storeVC = (VIStoreProfileViewController *) [store instantiateInitialViewController];
    [self.feedVC presentViewController:storeVC animated:YES completion:nil];
}

@end
