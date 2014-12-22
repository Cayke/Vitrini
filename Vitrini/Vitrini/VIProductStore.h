//
//  VIProductStore.h
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VIProductStore : NSObject

@property (nonatomic) NSMutableArray *products;

+(instancetype)sharedStore;

@end
