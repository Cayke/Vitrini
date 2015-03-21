//
//  VIImageAndLabelTableViewCell.h
//  Vitrini
//
//  Created by Cayke Prudente on 20/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIImageAndLabelTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

-(void) mountWithPosition:(int) position;

@end
