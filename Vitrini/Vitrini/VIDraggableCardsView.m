//
//  VIDraggableCardsView.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "VIDraggableCardsView.h"
#import "VIProductStore.h"

#define PARALLAX_BACK_VALUE 10

@implementation VIDraggableCardsView {
    NSInteger cardsLoadedIndex; //%%% the index of the card you have loaded into the loadedCards array last
    NSMutableArray *loadedCards; //%%% the array of card loaded (change max_buffer_size to increase or decrease the number of cards this holds)
    
    UIButton* menuButton;
    UIButton* messageButton;
    UIButton* checkButton;
    UIButton* xButton;
    
    UIButton *infoButton;
    UIButton *yesButton;
    UIButton *noButton;
}
//this makes it so only two cards are loaded at a time to
//avoid performance and memory costs
static const int MAX_BUFFER_SIZE = 2; //%%% max number of cards loaded at any given time, must be greater than 1
static float CARD_HEIGHT = 386; //%%% height of the draggable card
static float CARD_WIDTH = 290; //%%% width of the draggable card

@synthesize exampleCardPhotos; //%%% all the labels I'm using as example data at the moment
@synthesize allCards;//%%% all the cards

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // inicializar background
        [self setupBackgroundView];
        
        self.clickIsAvailable = YES;
        
        CARD_HEIGHT = self.frame.size.height;
        CARD_WIDTH = self.frame.size.width;
        
        
        [super layoutSubviews];
        
        exampleCardPhotos = [VIProductStore sharedStore].products;
        
        loadedCards = [[NSMutableArray alloc] init];
        allCards = [[NSMutableArray alloc] init];
        cardsLoadedIndex = 0;
        
        [self loadCards];
        
        [self setupFrontView];
    }
    return self;
}

-(void)setupBackgroundView{
    // background
    
    CGFloat correctionParallax = PARALLAX_BACK_VALUE/2;
    
    _background = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.origin.x-correctionParallax, self.frame.origin.y-correctionParallax, self.frame.size.width + PARALLAX_BACK_VALUE, self.frame.size.height + PARALLAX_BACK_VALUE)];
    _background.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_background];
    
    // blur background
    UIBlurEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = self.frame;
    [self addSubview:visualEffectView];
    
    // Set vertical effect
    
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-PARALLAX_BACK_VALUE);
    verticalMotionEffect.maximumRelativeValue = @(PARALLAX_BACK_VALUE);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-PARALLAX_BACK_VALUE);
    horizontalMotionEffect.maximumRelativeValue = @(PARALLAX_BACK_VALUE);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    // Add both effects to your view
    [_background addMotionEffect:group];
}

// adicionar informacoes na tela
-(void)setupFrontView
{
    // cor da paleta
    UIColor * linesColor = [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1.0f];
    
    // linhas
    UIView *firstLine = [[UIView alloc]initWithFrame:CGRectMake(92, 448, 50, 2)];
    firstLine.backgroundColor = linesColor;
    [self addSubview:firstLine];
    
    UIView *secondLine = [[UIView alloc]initWithFrame:CGRectMake(176, 448, 51, 2)];
    secondLine.backgroundColor = linesColor;
    [self addSubview:secondLine];
    
    // botao de sim
    yesButton = [[UIButton alloc]initWithFrame:CGRectMake(24, 415, 69, 69)];
    [yesButton setImage:[UIImage imageNamed:@"notBtn.png"] forState:UIControlStateNormal];
    [yesButton addTarget:self action:@selector(clickToswipeLeft) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:yesButton];
    
    // botao de nao
    noButton = [[UIButton alloc]initWithFrame:CGRectMake(226, 415, 69, 69)];
    [noButton setImage:[UIImage imageNamed:@"yesBtn.png"] forState:UIControlStateNormal];
    [noButton addTarget:self action:@selector(clickToswipeRight) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:noButton];
    
    // botao info
    infoButton = [[UIButton alloc]initWithFrame:CGRectMake(141, 431, 36, 36)];
    [infoButton setImage:[UIImage imageNamed:@"infoBtn.png"] forState:UIControlStateNormal];
    [self addSubview:infoButton];
}

#warning include own card customization here!
//%%% creates a card and returns it.  This should be customized to fit your needs.
// use "index" to indicate where the information should be pulled.  If this doesn't apply to you, feel free
// to get rid of it (eg: if you are building cards from data from the internet)
-(VICardView *)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    VICardView *draggableView = [[VICardView alloc]initWithFrame:CGRectMake((self.frame.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT)andProduct:[exampleCardPhotos objectAtIndex:index]];
    
    draggableView.delegate = self;
    draggableView.alpha = 0.0;
    
    return draggableView;
}

//%%% loads all the cards and puts the first x in the "loaded cards" array
-(void)loadCards
{
    if([exampleCardPhotos count] > 0) {
        NSInteger numLoadedCardsCap =(([exampleCardPhotos count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[exampleCardPhotos count]);
        //%%% if the buffer size is greater than the data size, there will be an array error, so this makes sure that doesn't happen
        
        //%%% loops through the exampleCardsLabels array to create a card for each label.  This should be customized by removing "exampleCardLabels" with your own array of data
        for (int i = 0; i<[exampleCardPhotos count]; i++) {
            VICardView* newCard = [self createDraggableViewWithDataAtIndex:i];
            [allCards addObject:newCard];
            
            if (i<numLoadedCardsCap) {
                //%%% adds a small number of cards to be loaded
                [loadedCards addObject:newCard];
            }
        }
        
        //%%% displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
        // are showing at once and clogging a ton of data
        for (int i = 0; i<[loadedCards count]; i++) {
            if (i>0) {
                [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
            } else {
                [self addSubview:[loadedCards objectAtIndex:i]];
            }
            [[self presentedCard]normalize];
            [self presentedCard].alpha = 1.0;
            [self changeBackgroundBlur];
            cardsLoadedIndex++; //%%% we loaded a card into loaded cards, so we have to increment
        }
    }
}

//%%% action called when the card goes to the left.
// This should be customized with your own action
-(void)cardSwipedLeft:(UIView *)card;
{
    [self swipedCardWillEnded];
}

//%%% action called when the card goes to the right.
// This should be customized with your own action
-(void)cardSwipedRight:(UIView *)card
{
    [self swipedCardWillEnded];
}

-(void)swipedCardWillEnded{
    [[self waitingCard] normalize];
    
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    
    [self changeBackgroundBlur];
}

//%%% when you hit the right button, this is called and substitutes the swipe
-(void)clickToswipeRight
{
    if (_clickIsAvailable) {
        self.clickIsAvailable = NO;
        VICardView *cardView = [loadedCards firstObject];
        [cardView rightClickAction];
    }
}

//%%% when you hit the left button, this is called and substitutes the swipe
-(void)clickToswipeLeft
{
    if (_clickIsAvailable) {
        self.clickIsAvailable = NO;
        VICardView *cardView = [loadedCards firstObject];
        [cardView leftClickAction];
    }
}

-(void)changeBackgroundBlur{
    VICardView *cardView = [loadedCards firstObject];
    _background.image = cardView.product.photo;
    [_background setAlpha:0.0];
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [_background setAlpha:1.0];
    } completion:nil];
    
    [self presentedCard].alpha = 1.0;
}

-(void)swipingViewDistanceFromCenter:(CGPoint)point{
    CGFloat distance = sqrtf((point.x*point.x)+(point.y*point.y));
    
    [[self waitingCard] animationBeingSecondCardWithFirstCardFactor: distance/400];
}

-(void)cancelSwiping{
    [[self waitingCard] setAlpha:0.0];
}

-(VICardView *)presentedCard{
    if ([loadedCards count]>0)
        return loadedCards[0];
    return nil;
}

-(VICardView *)waitingCard{
    if ([loadedCards count]>1)
        return loadedCards[1];
    return nil;
}

@end
