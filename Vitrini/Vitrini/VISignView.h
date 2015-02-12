//
//  VISignView.h
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Vitrini. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger , GGOverlayViewMode) {
    GGOverlayViewModeLeft,
    GGOverlayViewModeRight
};

@interface VISignView : UIView

@property (nonatomic) GGOverlayViewMode mode;
@property (nonatomic) BOOL wasDragging;
@property (nonatomic, strong) UIImageView *imageView;

-(void)setMode:(GGOverlayViewMode)mode andIsDragging:(BOOL)isDregging;

@end
