//
//  VIResponse.h
//  Vitrini
//
//  Created by Cayke Prudente on 19/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, VIRequestStatus) {
    VIRequestError,
    VIRequestSuccess
};

@protocol VIModelFileFromServer <NSObject>

-(instancetype)initWithValue:(id)value;
-(instancetype)initFromDevice;
-(void)save;

@end



@interface VIResponse : NSObject

@property (nonatomic, readonly) VIRequestStatus status;
@property (nonatomic, readonly) NSString *responseType;
@property (nonatomic, readonly) id value;

- (instancetype)initWithResponse:(NSData*)responsedata;

@end
