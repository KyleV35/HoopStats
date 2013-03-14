//
//  HSTeamViewController.m
//  HoopStats
//
//  Created by Kyle Vermeer on 3/12/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import "HSTeamViewController.h"
#import "HSGameViewController.h"
#import "HSEditTeamViewController.h"

@interface HSTeamViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *playersImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gamesImageView;
@property (weak, nonatomic) IBOutlet UIImageView *makeGameImageView;

@end

@implementation HSTeamViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.team.location length] == 0) {
        self.title = self.team.teamName;
    } else {
        self.title = [[self.team.location stringByAppendingString:@" "] stringByAppendingString:self.team.teamName];
    }
	[self.playersImageView setImage:[UIImage imageNamed:@"playerImage.png"]];
    [self.gamesImageView setImage:[UIImage imageNamed:@"gameImage.png"]];
    [self.makeGameImageView setImage:[UIImage imageNamed:@"createGameImage.png"]];
    
    [self.team addObserver:self forKeyPath:@"teamName" options:NSKeyValueObservingOptionNew context:NULL];
    [self.team addObserver:self forKeyPath:@"location" options:NSKeyValueObservingOptionNew context:NULL];
    
    //Add Gesture Recognizers
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playersButtonTapped)];
    [self.playersImageView addGestureRecognizer:gestureRecognizer];
    UITapGestureRecognizer *gamesButtonTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gamesButtonTapped)];
    [self.gamesImageView addGestureRecognizer:gamesButtonTapped];
    UITapGestureRecognizer *createGameTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createGameButtonTapped)];
    [self.makeGameImageView addGestureRecognizer:createGameTapped];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([self.team.location length] == 0) {
        self.title = self.team.teamName;
    } else {
        self.title = [[self.team.location stringByAppendingString:@" "] stringByAppendingString:self.team.teamName];
    }
}

-(void)playersButtonTapped
{
    NSLog(@"Players Button tapped");
}

-(void)createGameButtonTapped
{
    //[self performSegueWithIdentifier:@"createNewGame" sender:nil];
    [self performSegueWithIdentifier:@"selectOpposingTeam" sender:nil];
}

-(void)gamesButtonTapped
{
    NSLog(@"Games Button tapped");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"createNewGame"]) {
        HSGameViewController *gameController = segue.destinationViewController;
        gameController.leftTeam = self.team;
    } else if ([segue.identifier isEqualToString:@"editTeam"]) {
        HSEditTeamViewController *editTeamController = segue.destinationViewController;
        editTeamController.team = self.team;
    }
}

@end
