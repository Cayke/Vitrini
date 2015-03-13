//
//  VIDraggableCardsView.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Vitrini. All rights reserved.
//

#import "VIDraggableCardsView.h"
#import "VIProductStore.h"
#import "VIColor.h"
#import "VICardInfoViewController.h"

#define PARALLAX_BACK_VALUE 10

@implementation VIDraggableCardsView {
    //NSInteger cardsLoadedIndex; //%%% the index of the card you have loaded into the loadedCards array last
    NSMutableArray *loadedCards; //%%% the array of card loaded (change max_buffer_size to increase or decrease the number of cards this holds)
    
    UIView *firstLine;
    UIView *secondLine;
    UIButton *infoButton;
    UIButton *yesButton;
    UIButton *noButton;
    
    UIImageView *backgroundStatic;
    UIImageView *backgroundAnimat;
    
    UIImageView *waitingCardsAnim;
    BOOL animationOn;
    
    UIView *cardsLayer;
    
    BOOL inDispatch;
}
//this makes it so only two cards are loaded at a time to
//avoid performance and memory costs
static const int MAX_BUFFER_SIZE = 2; //%%% max number of cards loaded at any given time, must be greater than 1
static float CARD_HEIGHT = 386; //%%% height of the draggable card
static float CARD_WIDTH = 290; //%%% width of the draggable card

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // inicializar background
        [self setupBackgroundView];
        
        self.clickIsAvailable = YES;
        self.clickEvent = YES;
        self.waitingNewProducts = NO;
        animationOn = YES;
        inDispatch = NO;
        
        CARD_HEIGHT = self.frame.size.height;
        CARD_WIDTH = self.frame.size.width;
        
        
        [super layoutSubviews];
        
        loadedCards = [[NSMutableArray alloc] init];
        //cardsLoadedIndex = 0;
        
        cardsLayer = [[UIView alloc]initWithFrame:frame];
        [self addSubview:cardsLayer];
        
        [self mountCards];
        [self setupFrontView];
    }
    return self;
}


-(void)setupBackgroundView{
    // background
    
    CGFloat correctionParallax = PARALLAX_BACK_VALUE/2;
    
    CGRect backgroundFrame = CGRectMake(self.frame.origin.x-correctionParallax, self.frame.origin.y-correctionParallax, self.frame.size.width + PARALLAX_BACK_VALUE, self.frame.size.height + PARALLAX_BACK_VALUE);
    
    backgroundStatic = [[UIImageView alloc]initWithFrame:backgroundFrame];
    backgroundAnimat = [[UIImageView alloc]initWithFrame:backgroundFrame];
    backgroundStatic.contentMode = UIViewContentModeScaleAspectFill;
    backgroundAnimat.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:backgroundStatic];
    [self addSubview:backgroundAnimat];
    [backgroundAnimat setAlpha:0.0f];
    
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
    [backgroundStatic addMotionEffect:group];
    [backgroundAnimat addMotionEffect:group];
}

// adicionar informacoes na tela
-(void)setupFrontView
{
    CGFloat dimensionBtn = 69.0f;
    CGFloat dimensionBtnInfo = 36.0f;
    CGFloat marginToWall = 24.0f;
    CGFloat marginToBottom = 120.0f;
    
    CGFloat posX, posY, width, height;
    
    //
    //// calcular posicoes da primeira linha
    //
    posX = marginToWall + dimensionBtn - 1;
    width = (self.frame.size.width/2 - dimensionBtnInfo/2) - posX;
    posY = self.frame.size.height - marginToBottom;
    
    // linhas
    firstLine = [[UIView alloc]initWithFrame:CGRectMake(posX, posY-1, width, 2)];
    firstLine.backgroundColor = [VIColor whiteVIColor];
    [self addSubview:firstLine];
    
    //
    //// calcular posicoes da segunda linha
    //
    posX = self.frame.size.width/2 + dimensionBtnInfo/2 - 1;
    width += 1;
    posY = self.frame.size.height - marginToBottom;
    
    secondLine = [[UIView alloc]initWithFrame:CGRectMake(posX, posY-1, width, 2)];
    secondLine.backgroundColor = [VIColor whiteVIColor];
    [self addSubview:secondLine];
    
    //
    //// calcular posicoes do botao SIM
    //
    posX = marginToWall;
    width = dimensionBtn;
    height = dimensionBtn;
    posY = self.frame.size.height - marginToBottom - dimensionBtn/2;
    
    // botao de sim
    yesButton = [[UIButton alloc]initWithFrame:CGRectMake(posX, posY, dimensionBtn, dimensionBtn)];
    [yesButton setImage:[UIImage imageNamed:@"notBtn.png"] forState:UIControlStateNormal];
    [yesButton addTarget:self action:@selector(clickToswipeLeft) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:yesButton];
    
    //
    //// calcular posicoes do botao NAO
    //
    posX = self.frame.size.width - dimensionBtn - marginToWall;
    width = dimensionBtn;
    height = dimensionBtn;
    posY = self.frame.size.height - marginToBottom - dimensionBtn/2;
    
    // botao de nao
    noButton = [[UIButton alloc]initWithFrame:CGRectMake(posX, posY, dimensionBtn, dimensionBtn)];
    [noButton setImage:[UIImage imageNamed:@"yesBtn.png"] forState:UIControlStateNormal];
    [noButton addTarget:self action:@selector(clickToswipeRight) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:noButton];
    
    //
    //// calcular posicoes do botao INFO
    //
    posX = self.frame.size.width/2 - dimensionBtnInfo/2;
    width = dimensionBtnInfo;
    height = dimensionBtnInfo;
    posY = self.frame.size.height - marginToBottom - dimensionBtnInfo/2;
    
    // botao info
    infoButton = [[UIButton alloc]initWithFrame:CGRectMake(posX, posY, dimensionBtnInfo, dimensionBtnInfo)];
    [infoButton addTarget:self action:@selector(goToInfo) forControlEvents:UIControlEventTouchUpInside];
    [infoButton setImage:[UIImage imageNamed:@"infoBtn.png"] forState:UIControlStateNormal];
    [self addSubview:infoButton];
    
    //
    //// CALCULAR POSICAO DA IMAGEM DE LENDO CARTPES
    //
    CGFloat squareSize = 160.0;
    posX = self.frame.size.width/2 - squareSize/2;
    posY = self.frame.size.height/2 - squareSize/2;
    
    // IMAGEM DE CARREGANDO
    waitingCardsAnim = [[UIImageView alloc]initWithFrame:CGRectMake(posX, posY, squareSize, squareSize)];
    [waitingCardsAnim setImage:[UIImage imageNamed:@"looking.png"]];
    waitingCardsAnim.hidden = YES;
    [self addSubview:waitingCardsAnim];
}

-(void)animatBinoculus{
    NSLog(@"anim");
    CGFloat squareSize = 160.0;
    __unused CGRect frame1 = CGRectMake(self.frame.size.width/2 - squareSize/2, self.frame.size.height - squareSize/2, squareSize, squareSize);
    squareSize = 140.0;
    __unused CGRect frame2 = CGRectMake(self.frame.size.width/2 - squareSize/2, self.frame.size.height - squareSize/2, squareSize, squareSize);
    squareSize = 200.0;
    __unused CGRect frame3 = CGRectMake(self.frame.size.width/2 - squareSize/2, self.frame.size.height - squareSize/2, squareSize, squareSize);
    
    [waitingCardsAnim setAlpha:1];
    [UIView animateWithDuration: 0.4
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations: ^{
                         [waitingCardsAnim setAlpha:0.6];
                     } completion: ^(BOOL finished){
                         if (!animationOn) {
                             [UIView setAnimationRepeatCount: 0];
                         }
                     }];
}

-(void) goToInfo
{
    UIStoryboard *cards = [UIStoryboard storyboardWithName:@"Cards" bundle:nil];
    VICardInfoViewController *info = [cards instantiateViewControllerWithIdentifier:@"VICardInfoViewControllerID"];
    [self.VICardsVC presentViewController:info animated:YES completion:nil];
}

//%%% creates a card and returns it.
// use "index" to indicate where the information should be pulled.  If this doesn't apply to you, feel free
// to get rid of it (eg: if you are building cards from data from the internet)
-(VICardView *)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    VICardView *draggableView = [[VICardView alloc]initWithFrame:self.frame andProduct:[[VIProductStore sharedStore] nextProduct]];
    
    draggableView.delegate = self;
    draggableView.alpha = 0.0;
    
    return draggableView;
}

-(VICardView*)createCardWithProduct:(VIProduct*)product{
    VICardView *draggableView = [[VICardView alloc]initWithFrame:self.frame andProduct:product];
    
    draggableView.delegate = self;
    draggableView.alpha = 0.0;
    
    return draggableView;
}

-(void)loadWithCategoryID:(int)categoryID{
    [self clearCards];
    [[VIProductStore sharedStore] changeCategoryID:categoryID];
    [self mountCards];
    inDispatch = NO;
}

-(void)mountCards{
    if (!inDispatch) {
        inDispatch = YES;
        //aqui botamos as coisas na tela
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        [self hiddeControlls];
        waitingCardsAnim.hidden = NO;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            BOOL readed = NO;
            BOOL cancel = NO;
            @try {
                readed = [[VIProductStore sharedStore]loadCards];
            }
            @catch (NSException *exception) {
                if (![exception.name isEqual:@"MAX_COUNTER_INCREMENT"]) {
                    @throw exception;
                } else {
                    cancel = YES;
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                inDispatch = NO;
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
                if (!cancel) {
                    if (!readed) {
                        [self mountCards];
                    } else {
                        
                        [self fillCardBuffer];
                        [self loadCards];
                        
                        // esconder binoculo
                        waitingCardsAnim.hidden = YES;
                        [self showControlls];
                    }
                }
            });
        });
    }
}

-(void)reviewProduct:(VIProduct*)product withLiked:(BOOL)isLiked{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[VIProductStore sharedStore]reviewProductID:product.ID withLiked:isLiked];
    });
}

-(void)clearCards{
    for (VICardView *card in loadedCards) {
        [card removeFromSuperview];
    }
    [loadedCards removeAllObjects];
}

//%%% loads all the cards and puts the first x in the "loaded cards" array
-(void)loadCards
{
    
    //    if([exampleCardPhotos count] > 0) {
    //        NSInteger numLoadedCardsCap =(([exampleCardPhotos count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[exampleCardPhotos count]);
    //        //%%% if the buffer size is greater than the data size, there will be an array error, so this makes sure that doesn't happen
    //
    //        //%%% loops through the exampleCardsLabels array to create a card for each label.  This should be customized by removing "exampleCardLabels" with your own array of data
    //        for (int i = 0; i<[exampleCardPhotos count]; i++) {
    //            VICardView* newCard = [self createDraggableViewWithDataAtIndex:i];
    //            [allCards addObject:newCard];
    //
    //            if (i<numLoadedCardsCap) {
    //                //%%% adds a small number of cards to be loaded
    //                [loadedCards addObject:newCard];
    //            }
    //        }
    //
    //        //%%% displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
    //        // are showing at once and clogging a ton of data
    //        for (int i = 0; i<[loadedCards count]; i++) {
    //            if (i>0) {
    //                [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
    //            } else {
    //                [self addSubview:[loadedCards objectAtIndex:i]];
    //            }
    //            [[self presentedCard]normalize];
    //            [self presentedCard].alpha = 1.0;
    //            [self changeBackgroundBlur];
    //            cardsLoadedIndex++; //%%% we loaded a card into loaded cards, so we have to increment
    //        }
    //    }
    for (int i = 0; i < MAX_BUFFER_SIZE && i < [loadedCards count]; i++) {
        UIView *viproductCard = loadedCards[i];
        if (viproductCard) {
            [cardsLayer addSubview:viproductCard];
        }
    }
    
    //[cardsLayer addSubview:[loadedCards objectAtIndex:1]];
    //[cardsLayer addSubview:[loadedCards objectAtIndex:0]];
    [[self presentedCard]normalize];
    [self presentedCard].alpha = 1.0;
    [self changeBackgroundBlur];
}

-(void)fillCardBuffer{
    NSUInteger qtdOfCardsInBuffer = [loadedCards count];
    if (qtdOfCardsInBuffer < MAX_BUFFER_SIZE) {
        for (NSUInteger i = qtdOfCardsInBuffer; i < MAX_BUFFER_SIZE; i++) {
            VIProduct *nextProduct = [[VIProductStore sharedStore]nextProduct];
            if (nextProduct) {
                [loadedCards addObject:[self createCardWithProduct:nextProduct]];
            } else if(![loadedCards count] > 0){
                // nao tem proximo produto
                if ([loadedCards count]==0) {
                    // nao tem produto a ser mostrado
                    [self waitNewProducts];
                }
            }
        }
    }
}

//%%% action called when the card goes to the left.
// This should be customized with your own action
-(void)cardSwipedLeft:(UIView *)card;
{
    VICardView *cv = (VICardView*)card;
    [self reviewProduct:cv.product withLiked:NO];
    [self swipedCardWillEnded];
}

//%%% action called when the card goes to the right.
// This should be customized with your own action
-(void)cardSwipedRight:(UIView *)card
{
    VICardView *cv = (VICardView*)card;
    [self reviewProduct:cv.product withLiked:YES];
    [self swipedCardWillEnded];
}

-(void)swipedCardWillEnded{
    [[self waitingCard] normalize];
    
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    [self fillCardBuffer];
    
    if ([self waitingCard]) {
        // existe cartoes para serem mostrados
        [cardsLayer insertSubview:loadedCards[1] atIndex:0];
        //[cardsLayer insertSubview:loadedCards[1] belowSubview:loadedCards[0]];
        [[self presentedCard]normalize];
        [self presentedCard].alpha = 1.0;
    } else {
        NSLog(@"show loading...");
    }
    
    //    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
    //        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
    //        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
    //        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    //    }
    
    [self changeBackgroundBlur];
    _clickEvent = YES;
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
    
    if (cardView) {
        [backgroundAnimat setAlpha:0.0f];
        [backgroundAnimat setImage: cardView.product.photo];
        
        CGFloat delay = DELAY_OF_CARD_ANIMATION;
        if (!_clickEvent) {
            delay = 0.0;
        }
        
        [UIView animateWithDuration:0.4 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
            [backgroundAnimat setAlpha:1.0f];
        } completion:^(BOOL complete){
            [backgroundStatic setImage:cardView.product.photo];
            [backgroundAnimat setAlpha:1.0f];
        }];
    }
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

-(void)resetBackCard{
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [[self waitingCard] animationBeingSecondCardWithFirstCardFactor:0.0f];
    } completion:nil];
}

// esperar resposta de novos produtos da store
-(void)waitNewProducts{
    self.waitingNewProducts = YES;
    [self hiddeControlls];
    [self mountCards];
}

-(void)hiddeControlls{
    CGFloat delay = DELAY_OF_CARD_ANIMATION + 0.2f;
    if (!_clickEvent) {
        delay = 0.1f;
    }
    [UIView animateWithDuration: 0.4f
                          delay: delay
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         firstLine.alpha = 0.0f;
                         secondLine.alpha = 0.0f;
                         infoButton.alpha = 0.0f;
                         yesButton.alpha = 0.0f;
                         noButton.alpha = 0.0f;
                         backgroundStatic.alpha = 0.0f;
                         backgroundAnimat.alpha = 0.0f;
                     }
                     completion:nil];
}

-(void)showControlls{
    [UIView animateWithDuration: 0.2f
                          delay: 0.0f
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         firstLine.alpha = 1.0f;
                         secondLine.alpha = 1.0f;
                         infoButton.alpha = 1.0f;
                         yesButton.alpha = 1.0f;
                         noButton.alpha = 1.0f;
                         backgroundStatic.alpha = 1.0f;
                         backgroundAnimat.alpha = 1.0f;
                     }
                     completion:nil];
}

@end
