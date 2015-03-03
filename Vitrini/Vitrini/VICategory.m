//
//  VICategory.m
//  Vitrini
//
//  Created by Cayke Prudente on 02/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VICategory.h"
#import "VISymbolsPackage.h"

@implementation VICategory

-(instancetype) initWithDicFromServer:(NSDictionary *) dic{
    self = [super init];
    if (self) {
        VISymbolsPackage *symbPack = [[VISymbolsPackage alloc]init];
        self.idCategory = [[dic objectForKey:symbPack.ID]intValue];
        self.photoPath = [dic objectForKey:symbPack.image];
        self.name = [dic objectForKey:symbPack.title];
        self.active = NO;
    }
    return self;
}


@end
