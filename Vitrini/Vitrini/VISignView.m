//
//  VISignView.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Vitrini. All rights reserved.
//

#import "VISignView.h"

@implementation VISignView {
    CGFloat size;
    CGFloat posy;
    CGFloat disw;
    CGFloat dish;
}

@synthesize imageView;

- (id)initWithFrame:(CGRect)frameOfImage
{
    size = 160;
    
    posy = frameOfImage.origin.y;
    disw = frameOfImage.size.width;
    dish = frameOfImage.size.height;
    
    CGRect signFrame = CGRectMake((disw/2)-(size/2), ((dish/2)+posy)-(size/2), size, size);
    self = [super initWithFrame:signFrame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"noSign"]];
        [self addSubview:imageView];
    }
    return self;
}

-(void)setMode:(GGOverlayViewMode)mode
{
    
    _mode = mode;
    
    if(mode == GGOverlayViewModeLeft) {
        imageView.image = [UIImage imageNamed:@"noSign"];
    } else {
        imageView.image = [UIImage imageNamed:@"yesSign"];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    imageView.frame = CGRectMake(0,0, size, size);
}

@end
