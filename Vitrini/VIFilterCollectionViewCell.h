//
//  VIFilterCollectionViewCell.h
//  Vitrini
//
//  Created by Cayke Prudente on 05/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIFilterCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UIImageView *photoOnOff;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smallSquareCenter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigSquareCenter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelCenter;

-(void) mountWithPosition:(NSInteger) position;

@end
