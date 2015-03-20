//
//  VIStore.h
//  Vitrini
//
//  Created by Cayke Prudente on 23/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VILocation.h"

@interface VIStore : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *usuario;
@property (nonatomic) VILocation *location;
@property (nonatomic) NSArray * products;
@property (nonatomic) NSString *imageName;
@property (nonatomic) NSString *coverName;
@property (nonatomic) int storeID;
@property (nonatomic) BOOL isFollowing;
@property (nonatomic) NSString *resume;

@property (nonatomic) NSString *address;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

-(instancetype) initWithDictionary:(NSDictionary *) dict;

@end
