//
//  VIStore.m
//  Vitrini
//
//  Created by Cayke Prudente on 23/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIStore.h"

#import "VISymbolsPackage.h"

@implementation VIStore

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self mountWithDict:dict];
    }
    return self;
}

-(void)mountWithDict:(NSDictionary *)dict{
    VISymbolsPackage *symbPack = [[VISymbolsPackage alloc]init];
    
    _name = [dict objectForKey:@"name"];
    if ([[dict objectForKey:@"storeID"]intValue] > 0) {
        _storeID = [[dict objectForKey:@"storeID"]intValue];
    }
    else{
        _storeID = [[dict objectForKey:@"ID"]intValue];
    }
    if ([dict objectForKey:@"image"]) {
        _imageName = [dict objectForKey:@"image"];
    }
    else
    {
        _imageName = [dict objectForKey:@"photo"];
    }
    _address = [dict objectForKey:@"address"];
    _isFollowing = [[dict objectForKey:@"following"]boolValue];
    _resume = [dict objectForKey:@"resume"];
    
    _longitude = [[dict objectForKey:symbPack.longitude] doubleValue];
    _latitude = [[dict objectForKey:symbPack.latitude]doubleValue];
    
    _coverName = [dict objectForKey:symbPack.cover];
}

@end
