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

-(void)viewWillAppear:(BOOL)animated
{
    
}
                                    
-(void)twoPoint
{
    NSLog(@"two points!");
}

-(void)makeTwoPointButtons
{
    HSStatButton *twoPointMadeButton = [[HSStatButton alloc] initWithFrame:CGRectMake(10, 10, 50, 50) type:HSStatButtonTypeTwoPointMade];
    [self.view addSubview:twoPointMadeButton];
    HSStatButton *twoPointMissButton = [[HSStatButton alloc] initWithFrame:CGRectMake(65, 10, 50, 50) type:HSStatButtonTypeTwoPointMiss];
    [self.view addSubview:twoPointMissButton];
}

-(void)makeThreePointButtons
{
    HSStatButton *threePointMadeButton = [[HSStatButton alloc] initWithFrame:CGRectMake(130, 10, 50, 50) type:HSStatButtonTypeThreePointMade];
    [self.view addSubview:threePointMadeButton];
    HSStatButton *threePointMissButton = [[HSStatButton alloc] initWithFrame:CGRectMake(185, 10, 50, 50) type:HSStatButtonTypeThreePointMiss];
    [self.view addSubview:threePointMissButton];
}

-(void)makeOnePointButtons
{
    
    HSStatButton *onePointMadeButton = [[HSStatButton alloc] initWithFrame:CGRectMake(10, 70, 50, 50) type:HSStatButtonTypeOnePointMade];
    [self.view addSubview:onePointMadeButton];
    HSStatButton *onePointMissButton = [[HSStatButton alloc] initWithFrame:CGRectMake(65, 70, 50, 50) type:HSStatButtonTypeOnePointMiss];
    [self.view addSubview:onePointMissButton];
}

-(void)makeStealButton
{
    HSStatButton *stealButton = [[HSStatButton alloc] initWithFrame:CGRectMake(10, 130, 50, 50) type:HSStatButtonTypeSteal];
    [self.view addSubview:stealButton];
}

-(void)makeAssistButton
{
    HSStatButton *stealButton = [[HSStatButton alloc] initWithFrame:CGRectMake(65, 130, 50, 50) type:HSStatButtonTypeAssist];
    [self.view addSubview:stealButton];
}

-(void)makeTurnoverButton
{
    HSStatButton *turnoverButton = [[HSStatButton alloc] initWithFrame:CGRectMake(130, 130, 50, 50) type:HSStatButtonTurnover];
    [self.view addSubview:turnoverButton];
}

-(void)makeFoulButton
{
    HSStatButton *foulButton = [[HSStatButton alloc] initWithFrame:CGRectMake(185, 130, 50, 50) type:HSStatButtonFoul];
    [self.view addSubview:foulButton];
}

-(void)makeReboundButtons
{
    HSStatButton *offensiveReboundButton = [[HSStatButton alloc] initWithFrame:CGRectMake(130, 70, 50, 50) type:HSStatButtonTypeOffensiveRebound];
    [self.view addSubview:offensiveReboundButton];
    HSStatButton *defensiveReboundButton = [[HSStatButton alloc] initWithFrame:CGRectMake(185, 70, 50, 50) type:HSStatButtonTypeDefensiveRebound];
    [self.view addSubview:defensiveReboundButton];
}

-(void)buttonPressed:(UIButton*)sender
{
    NSLog(sender.titleLabel.text);
}

@end
