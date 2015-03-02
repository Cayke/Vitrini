//
//  VIProduct.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "VIProduct.h"
#import "VISymbolsPackage.h"

@implementation VIProduct

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)dealloc{
    NSLog(@"desalocou");
}

-(instancetype)initWithProductFromServer:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        VISymbolsPackage *symbPack = [[VISymbolsPackage alloc]init];
        _idProduct = [[dict objectForKey:symbPack.ID]intValue];
        _name = [dict objectForKey:symbPack.name];
        _photoString = [dict objectForKey:symbPack.photo];
    }
    return self;
}
@end
