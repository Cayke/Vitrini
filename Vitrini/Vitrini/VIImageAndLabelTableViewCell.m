//
//  VIImageAndLabelTableViewCell.m
//  Vitrini
//
//  Created by Cayke Prudente on 20/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIImageAndLabelTableViewCell.h"
#import "VIColor.h"

@implementation VIImageAndLabelTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)mountWithPosition:(int)position
{
    if (position == 0) {
        _imageViewLabel.image = [UIImage imageNamed:@"profile27"];
        UIColor *color = [VIColor whiteVIColor];
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Nome" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (position == 1) {
        _imageViewLabel.image = [UIImage imageNamed:@"calendar179"];
        UIColor *color = [VIColor whiteVIColor];
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Data de Nascimento" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (position == 2) {
        _imageViewLabel.image = [UIImage imageNamed:@"pointer16"];
        UIColor *color = [VIColor whiteVIColor];
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Cidade" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (position == 3) {
        _imageViewLabel.image = [UIImage imageNamed:@"email103"];
        UIColor *color = [VIColor whiteVIColor];
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (position == 4) {
        _imageViewLabel.image = [UIImage imageNamed:@"Password"];
        UIColor *color = [VIColor whiteVIColor];
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Senha" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else if (position == 5) {
        _imageViewLabel.image = [UIImage imageNamed:@"Password"];
        UIColor *color = [VIColor whiteVIColor];
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirmar Senha" attributes:@{NSForegroundColorAttributeName: color}];
    }
}

@end
