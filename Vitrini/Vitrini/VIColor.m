//
//  VIColor.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 22/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "VIColor.h"

@implementation VIColor

+(UIColor*)primaryColor{
    CGFloat divided = 255.0;
    CGFloat red = 48.0/divided;
    CGFloat green = 63.0/divided;
    CGFloat blue = 82.0/divided;
    CGFloat alpha = 255.0/divided;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
+(UIColor *)whiteViColor{
    CGFloat divided = 255.0;
    CGFloat red = 247.0/divided;
    CGFloat green = 247.0/divided;
    CGFloat blue = 247.0/divided;
    CGFloat alpha = 255.0/divided;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];

}

+(UIColor *) redVIColor
{
    CGFloat divided = 255.0;
    CGFloat red = 234.0/divided;
    CGFloat green = 69.0/divided;
    CGFloat blue = 65.0/divided;
    CGFloat alpha = 255.0/divided;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
@end
