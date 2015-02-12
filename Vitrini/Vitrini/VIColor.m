//
//  VIColor.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 22/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "VIColor.h"

@implementation VIColor

+(UIColor*)blackVIColor //cor de texto,fundo claro
{
    CGFloat divided = 255.0;
    CGFloat red = 21.0/divided;
    CGFloat green = 42.0/divided;
    CGFloat blue = 24.0/divided;
    CGFloat alpha = 255.0/divided;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
+(UIColor*)blueVIColor //cor principal 2
{
    CGFloat divided = 255.0;
    CGFloat red = 25.0/divided;
    CGFloat green = 48.0/divided;
    CGFloat blue = 69.0/divided;
    CGFloat alpha = 255.0/divided;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
+(UIColor*)darkGrayVIColor //variacao cor principal 2
{
    CGFloat divided = 255.0;
    CGFloat red = 67.0/divided;
    CGFloat green = 76.0/divided;
    CGFloat blue = 77.0/divided;
    CGFloat alpha = 255.0/divided;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
+(UIColor*)redVIColor //cor principal 1
{
    CGFloat divided = 255.0;
    CGFloat red = 220.0/divided;
    CGFloat green = 66.0/divided;
    CGFloat blue = 58.0/divided;
    CGFloat alpha = 255.0/divided;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
+(UIColor*)lightRedVIColor //variacao cor principal 1
{
    CGFloat divided = 255.0;
    CGFloat red = 226.0/divided;
    CGFloat green = 85.0/divided;
    CGFloat blue = 83.0/divided;
    CGFloat alpha = 255.0/divided;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
}
+(UIColor*)grayVIColor //cor extra 1
{
    CGFloat divided = 255.0;
    CGFloat red = 134.0/divided;
    CGFloat green = 139.0/divided;
    CGFloat blue = 129.0/divided;
    CGFloat alpha = 255.0/divided;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
+(UIColor*)lightGrayVIColor //cor extra 2
{
    CGFloat divided = 255.0;
    CGFloat red = 179.0/divided;
    CGFloat green = 174.0/divided;
    CGFloat blue = 154.0/divided;
    CGFloat alpha = 255.0/divided;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
+(UIColor*)darkWhiteVIColor //cor extra 3
{
    CGFloat divided = 255.0;
    CGFloat red = 203.0/divided;
    CGFloat green = 200.0/divided;
    CGFloat blue = 190.0/divided;
    CGFloat alpha = 255.0/divided;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
+(UIColor*)whiteVIColor // cor de texto, fundo escuro
{
    CGFloat divided = 255.0;
    CGFloat red = 249.0/divided;
    CGFloat green = 250.0/divided;
    CGFloat blue = 251.0/divided;
    CGFloat alpha = 255.0/divided;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
}
@end
