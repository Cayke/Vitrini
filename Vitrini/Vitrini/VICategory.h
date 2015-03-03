//
//  VICategory.h
//  Vitrini
//
//  Created by Cayke Prudente on 02/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VICategory : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *photoPath;
@property (nonatomic) int idCategory;

-(instancetype) initWithDicFromServer:(NSDictionary *) dic;

@end
