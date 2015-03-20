//
//  VIAllocFilterIcon.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 18/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIAllocFilterIcon.h"

#define ICON_SIZE 30.0f

@implementation VIAllocFilterIcon

+(void)chargeIconOnView:(UIView *)view {
    CGFloat dimension = view.frame.size.width;
    UIImageView *filterIcon = [[UIImageView alloc]initWithFrame:CGRectMake(dimension/2-ICON_SIZE/2, 45, ICON_SIZE, ICON_SIZE)];
    filterIcon.image = [UIImage imageNamed:@"icon-categorias-top"];
    filterIcon.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:filterIcon];
}

@end
