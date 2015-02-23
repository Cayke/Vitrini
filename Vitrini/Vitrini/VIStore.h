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

@property (nonatomic) NSString *nome;
@property (nonatomic) NSString *usuario;
@property (nonatomic) VILocation *location;
@property (nonatomic) NSArray * products;

@end
