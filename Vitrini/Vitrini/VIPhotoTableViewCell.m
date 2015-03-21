//
//  VIPhotoTableViewCell.m
//  Vitrini
//
//  Created by Cayke Prudente on 20/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIPhotoTableViewCell.h"

@implementation VIPhotoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)mountWithImage:(NSData *)image
{
    _mainPicture.layer.cornerRadius = _mainPicture.frame.size.width / 2;
    _mainPicture.clipsToBounds = YES;
    
    _mainPicture.image = [UIImage imageWithData:image];
    
    
    _backgroundImg.image = _mainPicture.image;
    
    if (!_blurSet) {
    //botar blue no background
    UIBlurEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = _backgroundImg.frame;
    [_backgroundImg addSubview:visualEffectView];
        
        _blurSet = YES;
    }
    
}

@end
