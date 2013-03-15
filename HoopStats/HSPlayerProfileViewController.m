//
//  HSPlayerProfileViewController.m
//  HoopStats
//
//  Created by Kyle Vermeer on 3/15/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import "HSPlayerProfileViewController.h"
#import "Season.h"
#import "Team.h"
#import "GameStatLine.h"

@interface HSPlayerProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *playerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;

@end

@implementation HSPlayerProfileViewController

-(void)setPlayer:(Player *)player
{
    _player = player;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",self.player.firstName,self.player.lastName];
    self.numberLabel.text = self.player.jerseyNumber.stringValue;
    Team *currentTeam = ((Season*)[[self.player.seasons allObjects] objectAtIndex:0]).team;
    self.teamLabel.text = [NSString stringWithFormat:@"%@ %@",currentTeam.location, currentTeam.teamName];
    int totalCareerPoints = 0;
    for (GameStatLine *statLine in self.player.gameStatLines) {
        totalCareerPoints += statLine.twoPointsMade.intValue*2 +statLine.threePointsMade.intValue*3 +statLine.onePointMade.intValue;
    }
    self.pointsLabel.text = [NSString stringWithFormat:@"%d",totalCareerPoints];
}

@end
