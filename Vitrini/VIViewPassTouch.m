//
//  VIViewPassTouch.m
//  Vitrini
//
//  Created by Cayke Prudente on 14/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIViewPassTouch.h"

@implementation VIViewPassTouch

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self){
        return nil;
    }
    else {
        return hitView;
    }
}


@end
