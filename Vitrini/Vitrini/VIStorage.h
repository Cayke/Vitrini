//
//  VIStorage.h
//  Vitrini
//
//  Created by Cayke Prudente on 20/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VIUser.h"

@interface VIStorage : NSObject

@property (nonatomic, readonly) VIUser *user;

+(VIStorage *) sharedStorage;

////////////////////////
//////  USER    ////////
////////////////////////
-(VIUser*)getUser;
-(void)saveUser;
-(BOOL)initUserFromDevice;
-(void)setUser:(VIUser *)newUser;
-(void)logOutUser;

////////////////////////
// DIC MANIPULATION   //
////////////////////////
-(BOOL)saveDictionary:(NSDictionary*)dict withFileName:(NSString*)fileName;
-(NSDictionary*)loadDictionaryFileName:(NSString*)fileName;

@end
