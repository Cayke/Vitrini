//
//  VIServer.h
//  Vitrini
//
//  Created by Cayke Prudente on 19/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VIResponse.h"

@interface VIServer : NSObject

-(VIResponse *) registerWithEmail:(NSString *) email
                      andPassword:(NSString *) pass
                    andFacebookID:(NSString *) fbID
                          andName:(NSString *) name
                          andCity:(NSString *) city
                      andBirthday:(NSString *) birthday
                        andGender:(NSString *) gender;

-(VIResponse *) loginWithEmail:(NSString *) email
                   andPassword:(NSString *) pass
                 andFacebookID:(NSString *) fbID;




@end
