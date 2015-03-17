//
//  VICatalogTableViewCell.m
//  Vitrini
//
//  Created by Cayke Prudente on 21/01/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VICatalogTableViewCell.h"

@implementation VICatalogTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)mountWithCategory:(VICategory *)category
{
    _iconImageView.image = nil;
    _iconImageView.crossfadeDuration = 0;
    _iconImageView.activityIndicatorStyle = UIActivityIndicatorViewStyleWhite;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://107.170.189.125/vitrini/default/download/db/%@", category.photoPath]];
    _iconImageView.imageURL = url;
    
    _labelName.text = category.name;
}

-(void)mountWithStore:(VIStore *)store
{
    _iconImageView.image = nil;
        _iconImageView.crossfadeDuration = 0;
    _iconImageView.activityIndicatorStyle = UIActivityIndicatorViewStyleWhite;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://107.170.189.125/vitrini/default/download/db/%@", store.imageName]];
    _iconImageView.imageURL = url;
    
    _labelName.text = store.name;
}


@end
