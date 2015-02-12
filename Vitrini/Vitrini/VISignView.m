//
//  VISignView.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Vitrini. All rights reserved.
//

#import "VISignView.h"

@implementation VISignView

@synthesize imageView;

- (id)initWithFrame:(CGRect)frameOfImage
{
    CGFloat size = 120.0;
    
    CGFloat posy = frameOfImage.origin.y;
    CGFloat disw = frameOfImage.size.width;
    CGFloat dish = frameOfImage.size.height;
    
    CGRect signFrame = CGRectMake((disw/2)-(size/2), ((dish/2)+posy)-(size/2), size, size);
    self = [super initWithFrame:signFrame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"noButton"]];
        [self addSubview:imageView];
    }
    return self;
}

-(void)setMode:(GGOverlayViewMode)mode
{
    if (_mode == mode) {
        return;
    }
    
    _mode = mode;
    
    if(mode == GGOverlayViewModeLeft) {
        imageView.image = [UIImage imageNamed:@"noButton"];
        self.backgroundColor = [UIColor redColor];
    } else {
        imageView.image = [UIImage imageNamed:@"yesButton"];
        self.backgroundColor = [UIColor greenColor];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    imageView.frame = CGRectMake(50, 50, 100, 100);
}

@end
