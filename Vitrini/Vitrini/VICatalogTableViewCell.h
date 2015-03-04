//
//  VICatalogTableViewCell.h
//  Vitrini
//
//  Created by Cayke Prudente on 21/01/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VICategory.h"
#import "AsyncImageView.h"

@interface VICatalogTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet AsyncImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelName;

-(void) mountWithCategory:(VICategory *) category;

@end
