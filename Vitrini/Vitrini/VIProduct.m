//
//  VIProduct.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "VIProduct.h"

@implementation VIProduct

- (instancetype)init
{
    self = [super init];
    if (self) {
        _liked = NO;
    }
    return self;
}

-(void)dealloc{
    NSLog(@"desalocou");
}

@end
