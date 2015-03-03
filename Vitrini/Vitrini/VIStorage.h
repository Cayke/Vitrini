//
//  VIStorage.h
//  Vitrini
//
//  Created by Cayke Prudente on 20/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VIUser.h"
#import "VIResponse.h"

@interface VIStorage : NSObject

@property (nonatomic, readonly) VIUser *user;

//todo : criar array com as categorias(sapato, calca, blusa)
@property (nonatomic) NSArray *categories;

+(VIStorage *) sharedStorage;

////////////////////////
//////  USER    ////////
////////////////////////
-(VIUser*)getUser;
-(void)saveUser;
-(BOOL)initUserFromDevice;
-(void)initUserFromServer:(NSDictionary *) dicUser;
-(void)setUser:(VIUser *)newUser;
-(void)logOutUser;

////////////////////////
// DIC MANIPULATION   //
////////////////////////
-(BOOL)saveDictionary:(NSDictionary*)dict withFileName:(NSString*)fileName;
-(NSDictionary*)loadDictionaryFileName:(NSString*)fileName;

////////////////////////
//////  lIKES    ////////
////////////////////////
//retorna array de VIProdcuts com (ID,name,photo)
-(NSArray *)createLikesProductsWithResponse:(VIResponse *) response;

@end
