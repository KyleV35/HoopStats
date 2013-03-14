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
#import "HSSelectOpposingTeamViewController.h"

@interface HSTeamViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *playersImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gamesImageView;
@property (weak, nonatomic) IBOutlet UIImageView *makeGameImageView;

@property (strong, nonatomic) Team *opposingTeam;

@end

@implementation HSTeamViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self updateTitle];
	[self.playersImageView setImage:[UIImage imageNamed:@"playerImage.png"]];
    [self.gamesImageView setImage:[UIImage imageNamed:@"gameImage.png"]];
    [self.makeGameImageView setImage:[UIImage imageNamed:@"createGameImage.png"]];
    
    //Add Gesture Recognizers
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playersButtonTapped)];
    [self.playersImageView addGestureRecognizer:gestureRecognizer];
    UITapGestureRecognizer *gamesButtonTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gamesButtonTapped)];
    [self.gamesImageView addGestureRecognizer:gamesButtonTapped];
    UITapGestureRecognizer *createGameTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createGameButtonTapped)];
    [self.makeGameImageView addGestureRecognizer:createGameTapped];
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
        gameController.rightTeam = self.opposingTeam;
    } else if ([segue.identifier isEqualToString:@"editTeam"]) {
        HSEditTeamViewController *editTeamController = segue.destinationViewController;
        editTeamController.team = self.team;
    }
}

#pragma mark Modal View Controller Unwinds

-(IBAction)editCancelled:(UIStoryboardSegue*)segue
{
    //Do nothing
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)editAccepted:(UIStoryboardSegue*)segue
{
    //Make changes to team
    HSEditTeamViewController *modalController = segue.sourceViewController;
    self.team.teamName = modalController.teamName;
    self.team.location = modalController.teamLocation;
    [self dismissViewControllerAnimated:YES completion:nil];
    [self updateTitle];
}

-(IBAction)opposingTeamSelected:(UIStoryboardSegue*)segue
{
    HSSelectOpposingTeamViewController *modalController = segue.sourceViewController;
    self.opposingTeam = modalController.selectedTeam;
    [self dismissViewControllerAnimated:YES completion:^{
       [self performSegueWithIdentifier:@"createNewGame" sender:self]; 
    }];
}

-(void)updateTitle
{
    if ([self.team.location length] == 0) {
        self.title = self.team.teamName;
    } else {
        self.title = [[self.team.location stringByAppendingString:@" "] stringByAppendingString:self.team.teamName];
    }
}


@end
