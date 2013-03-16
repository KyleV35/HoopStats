//
//  HSPlayerProfileViewController.m
//  HoopStats
//
//  Created by Kyle Vermeer on 3/15/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import "HSPlayerProfileViewController.h"
#import "Team.h"
#import "GameStatLine.h"
#import "HSStatLineCell.h"

@interface HSPlayerProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *playerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
    Team *currentTeam = self.player.team;
    self.teamLabel.text = [NSString stringWithFormat:@"%@ %@",currentTeam.location, currentTeam.teamName];
    int totalCareerPoints = 0;
    for (GameStatLine *statLine in self.player.gameStatLines) {
        totalCareerPoints += statLine.twoPointsMade.intValue*2 +statLine.threePointsMade.intValue*3 +statLine.onePointMade.intValue;
    }
    self.pointsLabel.text = [NSString stringWithFormat:@"%d",totalCareerPoints];
    [self.tableView registerNib:[UINib nibWithNibName:@"HSStatLineCell" bundle:nil] forCellReuseIdentifier:@"StatLineCell"];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StatLineCell";
    HSStatLineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell) {
        cell.player = self.player;
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

@end
