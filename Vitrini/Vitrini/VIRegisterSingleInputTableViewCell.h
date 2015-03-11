//
//  VIRegisterSingleInputTableViewCell.h
//  Vitrini
//
//  Created by Willian Pinho on 3/5/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIUser.h"

@interface VIRegisterSingleInputTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *singleInput;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (nonatomic) VIUser *auxUser;

@end
