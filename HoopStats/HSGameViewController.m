//
//  HSGameViewController.m
//  HoopStats
//
//  Created by Kyle Vermeer on 3/7/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import "HSGameViewController.h"
#import "HSAddStatViewController.h"
#import "Game+Create.h"
#import "Player.h"
#import "GameStatLine+Create.h"

#define NUM_RECENT_HIGHLIGHTS 3

@interface HSGameViewController () <UITableViewDelegate, UITableViewDataSource, AddStatDelegate>

@property (strong, nonatomic) UIPopoverController *popover;
@property (weak, nonatomic) IBOutlet UITableView *RecentHighlightsTableView;
@property (strong, nonatomic) NSArray* recentHighlights;
@property (weak, nonatomic) IBOutlet UILabel *leftTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTeamLabel;
@property (strong, nonatomic) Game *game;
@property (strong, nonatomic) NSArray *leftTeamPlayers;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *leftTeamButtons;

@end

@implementation HSGameViewController

-(void)viewDidLoad
{
    self.game = [Game gameWithTeam:self.leftTeam againstOpponent:self.rightTeam inManagedObjectContext:self.moc];
    self.recentHighlights = @[@"3pt made - 32 Spurs",@"Foul - 45 Timberwolves", @"Steal - 33 Spurs"];
    self.leftTeamLabel.text = self.leftTeam.teamName;
    self.rightTeamLabel.text = self.rightTeam.teamName;
    self.leftTeamPlayers = [[self.leftTeam.players allObjects] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Player *firstPlayer = (Player*)obj1;
        Player *secondPlayer = (Player*)obj2;
        if (firstPlayer.jerseyNumber > secondPlayer.jerseyNumber) {
            return NSOrderedDescending;
        } else if (firstPlayer.jerseyNumber < secondPlayer.jerseyNumber) {
            return NSOrderedAscending;
        } else {
            return NSOrderedSame;
        }
    }];
    for (UIButton* playerButton in self.leftTeamButtons) {
        NSUInteger index = [self.leftTeamButtons indexOfObject:playerButton];
        Player *player = [self.leftTeamPlayers objectAtIndex:index];
        [playerButton setTitle:player.jerseyNumber.stringValue forState:UIControlStateNormal];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSError *error = [[NSError alloc] init];
    [self.moc save:&error];
}

- (IBAction)playerButtonPushed:(UIButton *)sender
{
    Player* player = nil;
    if ([self.leftTeamButtons containsObject:sender]) {
        NSLog(@"A left team button was hit");
        player = [self leftPlayerForNumber:sender.titleLabel.text.integerValue];
    }
    NSLog(player.description);
    HSAddStatViewController *statPopoverController = [[HSAddStatViewController alloc] initWithPlayer:player];
    statPopoverController.addStatDelegate = self;
    self.popover = [[UIPopoverController alloc] initWithContentViewController:statPopoverController];
    self.popover.popoverContentSize = CGSizeMake(245.0, 190.0);
    [self.popover presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight animated:YES];
}

# pragma mark UITableViewDataSource

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Recent Highlight Cell"];
    cell.textLabel.text = self.recentHighlights[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return NUM_RECENT_HIGHLIGHTS;
}

-(Player*)leftPlayerForNumber:(NSUInteger)number
{
    for (Player* player in self.leftTeamPlayers) {
        if (player.jerseyNumber.integerValue == number) {
            return player;
        }
    }
    return nil;
}

#pragma mark AddStateDelegate

-(void)twoPointMade:(Player*)player
{
    GameStatLine *statLine = [self gameStatLineForPlayer:player];
    statLine.twoPointsAttempted= @(statLine.twoPointsAttempted.integerValue+1);
    statLine.twoPointsMade= @(statLine.twoPointsMade.integerValue+1);
    [self.popover dismissPopoverAnimated:YES];
    self.popover = nil;
}
-(void)twoPointMissed:(Player*)player
{
    GameStatLine *statLine = [self gameStatLineForPlayer:player];
    statLine.twoPointsAttempted= @(statLine.twoPointsAttempted.integerValue+1);
    [self.popover dismissPopoverAnimated:YES];
    self.popover = nil;
}
-(void)threePointMade:(Player*)player
{
    GameStatLine *statLine = [self gameStatLineForPlayer:player];
    statLine.threePointsAttempted= @(statLine.threePointsAttempted.integerValue+1);
    statLine.threePointsMade= @(statLine.threePointsMade.integerValue+1);
    [self.popover dismissPopoverAnimated:YES];
    self.popover = nil;
}
-(void)threePointMissed:(Player*)player
{
    GameStatLine *statLine = [self gameStatLineForPlayer:player];
    statLine.threePointsAttempted= @(statLine.threePointsAttempted.integerValue+1);
    [self.popover dismissPopoverAnimated:YES];
    self.popover = nil;
}
-(void)onePointMade:(Player*)player
{
    GameStatLine *statLine = [self gameStatLineForPlayer:player];
    statLine.onePointAttempted= @(statLine.onePointAttempted.integerValue+1);
    statLine.onePointMade= @(statLine.onePointMade.integerValue+1);
    [self.popover dismissPopoverAnimated:YES];
    self.popover = nil;
}
-(void)onePointMissed:(Player*)player
{
    GameStatLine *statLine = [self gameStatLineForPlayer:player];
    statLine.onePointAttempted= @(statLine.onePointAttempted.integerValue+1);
    [self.popover dismissPopoverAnimated:YES];
    self.popover = nil;
}
-(void)steal:(Player*)player
{
    GameStatLine *statLine = [self gameStatLineForPlayer:player];
    statLine.steals= @(statLine.steals.integerValue+1);
    [self.popover dismissPopoverAnimated:YES];
    self.popover = nil;
}
-(void)assist:(Player*)player
{
    GameStatLine *statLine = [self gameStatLineForPlayer:player];
    statLine.assists= @(statLine.assists.integerValue+1);
    [self.popover dismissPopoverAnimated:YES];
    self.popover = nil;
}
-(void)offensiveRebound:(Player*)player
{
    GameStatLine *statLine = [self gameStatLineForPlayer:player];
    statLine.offensiveRebounds= @(statLine.offensiveRebounds.integerValue+1);
    [self.popover dismissPopoverAnimated:YES];
    self.popover = nil;
}
-(void)defensiveRebound:(Player*)player
{
    GameStatLine *statLine = [self gameStatLineForPlayer:player];
    statLine.defensiveRebounds= @(statLine.defensiveRebounds.integerValue+1);
    [self.popover dismissPopoverAnimated:YES];
    self.popover = nil;
}
-(void)turnover:(Player*)player
{
    GameStatLine *statLine = [self gameStatLineForPlayer:player];
    statLine.turnovers= @(statLine.turnovers.integerValue+1);
    [self.popover dismissPopoverAnimated:YES];
    self.popover = nil;
}
-(void)foul:(Player*)player
{
    GameStatLine *statLine = [self gameStatLineForPlayer:player];
    statLine.fouls= @(statLine.fouls.integerValue+1);
    [self.popover dismissPopoverAnimated:YES];
    self.popover = nil;
}

-(GameStatLine*)gameStatLineForPlayer:(Player*)player
{
    for (GameStatLine *statLine in self.game.gameStatLines) {
        if ([player isEqual:statLine.player]) {
            return statLine;
        }
    }
    return nil;
}

@end
