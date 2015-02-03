//
//  VIFeedSectionView.m
//  Vitrini
//
//  Created by Cayke Prudente on 03/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIFeedSectionView.h"


@implementation VIFeedSectionView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self createLayout];
    
    return self;
}

-(void) createLayout
{
    //add fotinha loja
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 7, 30, 30)];
    imageView.image = [UIImage imageNamed:@"profile_feed_temp"];
    //botar foto redonda
    imageView.layer.cornerRadius = imageView.frame.size.width/2;
    imageView.clipsToBounds = YES;
    
    [self addSubview:imageView];
    
    //adicionar nome da loja
    UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake(50, 12, 200, 20)];
    labelName.text = @"rivaldo";

    [self addSubview:labelName];
    
    //linha seguinte para section nao ficar "transparente"
    //self.backgroundColor = [UIColor whiteColor];
}

@end
