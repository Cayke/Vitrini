//
//  VIPhotoTableViewCell.h
//  Vitrini
//
//  Created by Cayke Prudente on 20/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIPhotoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (weak, nonatomic) IBOutlet UIImageView *mainPicture;

-(void) mountWithImage:(NSData *) image;

@property (nonatomic) BOOL blurSet;

@end
