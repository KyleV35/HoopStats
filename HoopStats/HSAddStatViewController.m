//
//  HSAddStatViewController.m
//  HoopStats
//
//  Created by Kyle Vermeer on 3/7/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import "HSAddStatViewController.h"
#import "HSStatButton.h"

@interface HSAddStatViewController ()

@property (weak, nonatomic) Player *player;

@end

@implementation HSAddStatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self makeTwoPointButtons];
    [self makeThreePointButtons];
    [self makeOnePointButtons];
    [self makeReboundButtons];
    [self makeStealButton];
    [self makeAssistButton];
    [self makeTurnoverButton];
    [self makeFoulButton];
}

-(id)init
{
    NSLog(@"Init HSAddStateViewController with the method initWithPlayer");
    return nil;
}

-(id)initWithPlayer:(Player *)player
{
    self = [super init];
    if (self) {
        self.player = player;
    }
    return self;
}
                                    
-(void)twoPointMade
{
    [self.addStatDelegate twoPointMade:self.player];
}

-(void)twoPointMissed
{
    [self.addStatDelegate twoPointMissed:self.player];
}

-(void)threePointMade
{
    [self.addStatDelegate threePointMade:self.player];
}

-(void)threePointMiss
{
    [self.addStatDelegate threePointMissed:self.player];
}

-(void)onePointMade
{
    [self.addStatDelegate onePointMade:self.player];
}

-(void)onePointMiss
{
    [self.addStatDelegate onePointMissed:self.player];
}

-(void)steal
{
    [self.addStatDelegate steal:self.player];
}

-(void)assist
{
    [self.addStatDelegate assist:self.player];
}

-(void)offensiveRebound
{
    [self.addStatDelegate offensiveRebound:self.player];
}

-(void)defensiveRebound
{
    [self.addStatDelegate defensiveRebound:self.player];
}

-(void)turnover
{
    [self.addStatDelegate turnover:self.player];
}

-(void)foul
{
    [self.addStatDelegate foul:self.player];
}

-(void)makeTwoPointButtons
{
    // 2pt Made
    HSStatButton *twoPointMadeButton = [[HSStatButton alloc] initWithFrame:CGRectMake(10, 10, 50, 50) type:HSStatButtonTypeTwoPointMade];
    [twoPointMadeButton addTarget:self action:@selector(twoPointMade) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twoPointMadeButton];
    
    // 2pt Miss
    HSStatButton *twoPointMissButton = [[HSStatButton alloc] initWithFrame:CGRectMake(65, 10, 50, 50) type:HSStatButtonTypeTwoPointMiss];
    [twoPointMissButton addTarget:self action:@selector(twoPointMissed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twoPointMissButton];
}

-(void)makeThreePointButtons
{
    // 3pt Made
    HSStatButton *threePointMadeButton = [[HSStatButton alloc] initWithFrame:CGRectMake(130, 10, 50, 50) type:HSStatButtonTypeThreePointMade];
    [threePointMadeButton addTarget:self action:@selector(threePointMade) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:threePointMadeButton];
    
    // 3pt Miss
    HSStatButton *threePointMissButton = [[HSStatButton alloc] initWithFrame:CGRectMake(185, 10, 50, 50) type:HSStatButtonTypeThreePointMiss];
    [threePointMissButton addTarget:self action:@selector(threePointMiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:threePointMissButton];
}

-(void)makeOnePointButtons
{
    // 1pt Made
    HSStatButton *onePointMadeButton = [[HSStatButton alloc] initWithFrame:CGRectMake(10, 70, 50, 50) type:HSStatButtonTypeOnePointMade];
    [onePointMadeButton addTarget:self action:@selector(onePointMade) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:onePointMadeButton];
    
    // 1pt Miss
    HSStatButton *onePointMissButton = [[HSStatButton alloc] initWithFrame:CGRectMake(65, 70, 50, 50) type:HSStatButtonTypeOnePointMiss];
    [onePointMissButton addTarget:self action:@selector(onePointMiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:onePointMissButton];
}

-(void)makeStealButton
{
    HSStatButton *stealButton = [[HSStatButton alloc] initWithFrame:CGRectMake(10, 130, 50, 50) type:HSStatButtonTypeSteal];
    [stealButton addTarget:self action:@selector(steal) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stealButton];
}

-(void)makeAssistButton
{
    HSStatButton *assistButton = [[HSStatButton alloc] initWithFrame:CGRectMake(65, 130, 50, 50) type:HSStatButtonTypeAssist];
    [assistButton addTarget:self action:@selector(assist) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:assistButton];
}

-(void)makeTurnoverButton
{
    HSStatButton *turnoverButton = [[HSStatButton alloc] initWithFrame:CGRectMake(130, 130, 50, 50) type:HSStatButtonTurnover];
    [turnoverButton addTarget:self action:@selector(turnover) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:turnoverButton];
}

-(void)makeFoulButton
{
    HSStatButton *foulButton = [[HSStatButton alloc] initWithFrame:CGRectMake(185, 130, 50, 50) type:HSStatButtonFoul];
    [foulButton addTarget:self action:@selector(foul) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:foulButton];
}

-(void)makeReboundButtons
{
    // Offensive Rebound
    HSStatButton *offensiveReboundButton = [[HSStatButton alloc] initWithFrame:CGRectMake(130, 70, 50, 50) type:HSStatButtonTypeOffensiveRebound];
    [offensiveReboundButton addTarget:self action:@selector(offensiveRebound) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:offensiveReboundButton];
    
    // Defensive Rebound
    HSStatButton *defensiveReboundButton = [[HSStatButton alloc] initWithFrame:CGRectMake(185, 70, 50, 50) type:HSStatButtonTypeDefensiveRebound];
    [defensiveReboundButton addTarget:self action:@selector(defensiveRebound) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:defensiveReboundButton];
}

@end
