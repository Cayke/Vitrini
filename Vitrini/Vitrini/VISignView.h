//
//  VISignView.h
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger , GGOverlayViewMode) {
    GGOverlayViewModeLeft,
    GGOverlayViewModeRight
};

@interface VISignView : UIView

@property (nonatomic) GGOverlayViewMode mode;
@property (nonatomic, strong) UIImageView *imageView;

@end
