//
//  VICardView.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Vitrini. All rights reserved.
//

#define ACTION_MARGIN 120 //%%% distance from center where the action applies. Higher = swipe further in order for the action to be called
#define SCALE_STRENGTH 4 //%%% how quickly the card shrinks. Higher = slower shrinking
#define SCALE_MAX .93 //%%% upper bar for how much the card shrinks. Higher = shrinks less
#define ROTATION_MAX 1 //%%% the maximum rotation allowed in radians.  Higher = card can keep rotating longer
#define ROTATION_STRENGTH 320 //%%% strength of rotation. Higher = weaker rotation
#define ROTATION_ANGLE M_PI/8 //%%% Higher = stronger rotation angle

#define PARALLAX_CARD_VALUE 20
#define PADDING_OF_IMAGEVIEWFRAME_EFFECT 100


#import "VICardView.h"

@implementation VICardView {
    CGFloat xFromCenter;
    CGFloat yFromCenter;
}

//delegate is instance of ViewController
@synthesize delegate;

@synthesize signView;
@synthesize panGestureRecognizer;

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Wrong inicilization" reason:@"Use [initWithFrame:(CGRect)frame andProduct:(VIProduct*)product]" userInfo:nil];
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame andProduct:(VIProduct*)product
{
    self = [super initWithFrame:frame];
    if (self) {
        [self startView];
        _product = product;
        [self mountWithProduct];
    }
    return self;
}

-(void)startView{
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicou:)];
    [self addGestureRecognizer:tapGR];
    
    // reconhecer gesto
    panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(beingDragged:)];
    [self addGestureRecognizer:panGestureRecognizer];
}

-(void)clicou:(UITapGestureRecognizer*)gestureRecognizer{
    NSLog(@"clicou");
}

-(void)mountWithProduct{
    UIImage *image = _product.photo;
    
    // calcular frame
    CGFloat sx = self.frame.size.width / image.size.width;
    CGFloat sy = self.frame.size.height / image.size.height;
    CGFloat s = 1.0;
    
    s = fminf(sx, sy);
    CGSize size = CGSizeMake(s, s);
    
    CGFloat posX, posY, width, height;
    
    width = image.size.width*size.width;
    height = image.size.height*size.height;
    
    posX = CGRectGetMidX(self.frame) - width/2;
    posY = CGRectGetMidY(self.frame) - height/2;
    
    CGFloat correction = PARALLAX_CARD_VALUE/2;
    
    // adicionar imagem
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(posX-correction,posY-correction,width+PARALLAX_CARD_VALUE,height+PARALLAX_CARD_VALUE)];
    [imageview setImage:image];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageview];
    _imageView = imageview;
    _originalImageViewFrame = imageview.frame;
    
    // setar frame diferente para efeito
    width = _originalImageViewFrame.size.width - PADDING_OF_IMAGEVIEWFRAME_EFFECT;
    height= _originalImageViewFrame.size.height - PADDING_OF_IMAGEVIEWFRAME_EFFECT;
    
    CGFloat halfPadding = PADDING_OF_IMAGEVIEWFRAME_EFFECT/2;
    
    posX = _originalImageViewFrame.origin.x + halfPadding;
    posY = _originalImageViewFrame.origin.y + halfPadding;
    [imageview setFrame:CGRectMake(posX, posY, width, height)];
    
    
    // Set vertical effect
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-PARALLAX_CARD_VALUE);
    verticalMotionEffect.maximumRelativeValue = @(PARALLAX_CARD_VALUE);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-PARALLAX_CARD_VALUE);
    horizontalMotionEffect.maximumRelativeValue = @(PARALLAX_CARD_VALUE);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    // Add both effects to your view
    [imageview addMotionEffect:group];
    
    // colocar overlay na view (overlay = img que aparece quando se esta arrastando o cartao)
    signView = [[VISignView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-100, CGRectGetMidY(self.frame)-100, 100, 100)];
    signView.alpha = 0;
    [self addSubview:signView];
}


//%%% called when you move your finger across the screen.
// called many times a second
-(void)beingDragged:(UIPanGestureRecognizer *)gestureRecognizer
{
    //%%% this extracts the coordinate data from your swipe movement. (i.e. How much did you move?)
    xFromCenter = [gestureRecognizer translationInView:self].x; //%%% positive for right swipe, negative for left
    yFromCenter = [gestureRecognizer translationInView:self].y; //%%% positive for up, negative for down
    
    //%%% checks what state the gesture is in. (are you just starting, letting go, or in the middle of a swipe?)
    switch (gestureRecognizer.state) {
            //%%% just started swiping
        case UIGestureRecognizerStateBegan:{
            self.originalPoint = self.center;
            break;
        };
            //%%% in the middle of a swipe
        case UIGestureRecognizerStateChanged:{
            //%%% dictates rotation (see ROTATION_MAX and ROTATION_STRENGTH for details)
            CGFloat rotationStrength = MIN(xFromCenter / ROTATION_STRENGTH, ROTATION_MAX);
            
            //%%% degree change in radians
            CGFloat rotationAngel = (CGFloat) (ROTATION_ANGLE * rotationStrength);
            
            //%%% amount the height changes when you move the card up to a certain point
            CGFloat scale = MAX(1 - fabsf(rotationStrength) / SCALE_STRENGTH, SCALE_MAX);
            
            //%%% move the object's center by center + gesture coordinate
            self.center = CGPointMake(self.originalPoint.x + xFromCenter, self.originalPoint.y + yFromCenter);
            
            //%%% rotate by certain amount
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
            
            //%%% scale by certain amount
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            
            //%%% apply transformations
            self.transform = scaleTransform;
            [self updateOverlay:xFromCenter];
            
            [self.delegate swipingViewDistanceFromCenter:CGPointMake(xFromCenter, yFromCenter)];
            
            break;
        };
            //%%% let go of the card
        case UIGestureRecognizerStateEnded: {
            [self afterSwipeAction];
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:{
            [self resetCard];
            [self.delegate cancelSwiping];
            break;
        };
        case UIGestureRecognizerStateFailed:break;
    }
}

//%%% checks to see if you are moving right or left and applies the correct overlay image
-(void)updateOverlay:(CGFloat)distance
{
    if (distance > 0) {
        signView.mode = GGOverlayViewModeRight;
    } else {
        signView.mode = GGOverlayViewModeLeft;
    }
    
    signView.alpha = MIN(fabsf(distance)/100, 0.8);
}

//%%% called when the card is let go
- (void)afterSwipeAction
{
    if (xFromCenter > ACTION_MARGIN) {
        [delegate setClickEvent:NO];
        [self rightAction];
    } else if (xFromCenter < -ACTION_MARGIN) {
        [delegate setClickEvent:NO];
        [self leftAction];
    } else { //%%% resets the card
        [UIView animateWithDuration:0.3
                         animations:^{
                             [self resetCard];
                             [self.delegate resetBackCard];
                         }];
    }
}

// resetar cartao, colocar no meio
-(void)resetCard{
    self.center = self.originalPoint;
    self.transform = CGAffineTransformMakeRotation(0);
    signView.alpha = 0;
}

//%%% called when a swipe exceeds the ACTION_MARGIN to the right
-(void)rightAction
{
    CGPoint finishPoint = CGPointMake(600, 2*yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedRight:self];
    _product.liked = YES;
}

//%%% called when a swip exceeds the ACTION_MARGIN to the left
-(void)leftAction
{
    CGPoint finishPoint = CGPointMake(-600, 2*yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedLeft:self];
    _product.liked = NO;
}

-(void)rightClickAction
{
    signView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:0.1 animations:^{
        signView.alpha = 1;
    }];
    
    CGPoint finishPoint = CGPointMake(700, self.center.y);
    [UIView animateKeyframesWithDuration: 0.4
                                   delay: DELAY_OF_CARD_ANIMATION
                                 options: UIViewKeyframeAnimationOptionBeginFromCurrentState
                              animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(1);
                     }completion:^(BOOL complete){
                         [self.delegate setClickIsAvailable:YES];
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedRight:self];
    _product.liked = YES;
    NSLog(@"YES");
}

-(void)leftClickAction
{
    signView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:0.1 animations:^{
        signView.alpha = 1;
    }];
    
    CGPoint finishPoint = CGPointMake(-700, self.center.y);
    [UIView animateKeyframesWithDuration: 0.4
                                   delay: DELAY_OF_CARD_ANIMATION
                                 options: UIViewKeyframeAnimationOptionBeginFromCurrentState
                              animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(-1);
                     }completion:^(BOOL complete){
                         [self.delegate setClickIsAvailable:YES];
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedLeft:self];
    _product.liked = NO;
    NSLog(@"NO");
}

-(void)animationBeingSecondCardWithFirstCardFactor:(CGFloat)factor{
    
    self.alpha = factor-0.2;
    
    CGFloat inverseFactor = 0;
    if (factor < 1.0) {
        inverseFactor = 1 - factor;
    }
    
    CGFloat posX, posY, width, height;
    
    width = _originalImageViewFrame.size.width - (PADDING_OF_IMAGEVIEWFRAME_EFFECT * inverseFactor);
    height= _originalImageViewFrame.size.height - (PADDING_OF_IMAGEVIEWFRAME_EFFECT * inverseFactor);
    
    CGFloat halfPadding = PADDING_OF_IMAGEVIEWFRAME_EFFECT/2;
    
    posX = _originalImageViewFrame.origin.x + (halfPadding * inverseFactor);
    posY = _originalImageViewFrame.origin.y + (halfPadding * inverseFactor);
    
    CGRect effectFrame = CGRectMake(posX, posY, width, height);
    
    [_imageView setFrame:effectFrame];
}

-(void)normalize{
    CGFloat delay = DELAY_OF_CARD_ANIMATION;
    CGFloat animationTime = 0.4f;
    if (!delegate.clickEvent) {
        delay = 0.0;
        animationTime = 0.2f;
    }
    
    [UIView animateWithDuration:animationTime delay:delay options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [_imageView setFrame:_originalImageViewFrame];
        self.alpha = 1.0;
    } completion:nil];
}

-(void)informationOfProduct {
    
}

@end
