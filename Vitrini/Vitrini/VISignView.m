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
    CGFloat breath;
}

@synthesize imageView;

- (id)initWithFrame:(CGRect)frameOfImage
{
    breath = 40;
    size = 160;
    
    posy = frameOfImage.origin.y;
    disw = frameOfImage.size.width;
    dish = frameOfImage.size.height;
    
    CGRect signFrame = CGRectMake((disw/2)-(size/2), ((dish/2)+posy)-(size/2), size, size);
    self = [super initWithFrame:signFrame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"noSign"]];
        self.mode = GGOverlayViewModeLeft;
        self.wasDragging = NO;
        
        [self addSubview:imageView];
    }
    return self;
}

-(void)setMode:(GGOverlayViewMode)mode andIsDragging:(BOOL)isDregging
{
    if (_mode == mode && _wasDragging == isDregging) {
        return;
    }
    
    _mode = mode;
    _wasDragging = isDregging;
    
    if(mode == GGOverlayViewModeLeft) {
        imageView.image = [UIImage imageNamed:@"noSign"];
    } else {
        imageView.image = [UIImage imageNamed:@"yesSign"];
    }
    
    if (isDregging) {
        if (mode == GGOverlayViewModeLeft) {
            imageView.frame = [self frameNoSign];
        } else {
            imageView.frame = [self frameYesSign];
        }
    } else {
        imageView.frame = [self frameCenterSign];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    imageView.frame = [self frameCenterSign];
}

-(CGRect)frameCenterSign{
    return CGRectMake(0, -breath, size, size);
}

-(CGRect)frameNoSign{
    return CGRectMake(breath, -breath, size, size);
}

-(CGRect)frameYesSign{
    return CGRectMake(-breath, -breath, size, size);
}

@end
