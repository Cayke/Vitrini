//
//  VIProtocol.h
//  Vitrini
//
//  Created by Riheldo Melo Santos on 22/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol VIViewControllerMenuItemProtocol

@required
// icone para menu
-(UIImage*)itemMenuIcon;
// nome para menu
-(NSString*)itemMenuTitle;
@end


@interface VIProtocol : NSObject

@end
