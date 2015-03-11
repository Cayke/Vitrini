//
//  VIRegisterPhotoTableViewCell.m
//  Vitrini
//
//  Created by Willian Pinho on 3/11/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIRegisterPhotoTableViewCell.h"

@implementation VIRegisterPhotoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self designPhotos];
   

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) designPhotos
{
    
    //botar foto redonda
    _photoImageView.layer.cornerRadius = self.frame.size.height * 5/4;
    _photoImageView.clipsToBounds = YES;
    
    //colocar blur effect na background
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [blurEffectView setFrame:self.frame];
    
    //colocar vibrancy effect
    UIVibrancyEffect * vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc]initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:self.frame];
    
    [blurEffectView addSubview:vibrancyEffectView];
    
    //adicionar o blur a view
    [_backgroundImageView addSubview:blurEffectView];
    
}


@end
