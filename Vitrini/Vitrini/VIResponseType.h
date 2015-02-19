//
//  VIResponseType.h
//  Vitrini
//
//  Created by Cayke Prudente on 19/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VIResponseType : NSObject

@property (nonatomic, readonly) NSString
*accessDenied,
*serverError,
*emailAlreadyExist,
*registerUserWithSuccess,
*cadastreNotFound,
*passwordDoesntMatch,
*userInfosChanged,
*tokenSaved,
*productReviewed;

@end
