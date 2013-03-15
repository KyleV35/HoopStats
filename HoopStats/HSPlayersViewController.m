//
//  HSPlayersViewController.m
//  HoopStats
//
//  Created by Kyle Vermeer on 3/14/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import "HSPlayersViewController.h"
#import "HSEditPlayerViewController.h"
#import "HSPlayerProfileViewController.h"
#import "HSDatabase.h"
#import "Season.h"
#import "Player+Create.h"

@interface HSPlayersViewController ()

@property (weak, nonatomic) NSManagedObjectContext *moc;
@property (strong, nonatomic) NSArray *playersArray;

@end

@implementation HSPlayersViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [[HSDatabase sharedInstance] performWithDocument:^(UIManagedDocument *document) {
        self.moc = document.managedObjectContext;
    }];
}

-(void)setTeam:(Team *)team
{
    _team = team;
    Season *currentSeason = [[team.seasons allObjects] lastObject];
    self.playersArray = [currentSeason.players allObjects];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.playersArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Player Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Player *player = [self.playersArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [player description];
    
    return cell;
}

- (IBAction)addButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"addPlayer" sender:self];
}

-(IBAction)addCancelled:(UIStoryboardSegue*)segue
{
    //Do nothing
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)addAccepted:(UIStoryboardSegue*)segue
{
    //Make changes to team
    HSEditPlayerViewController *editPlayerController = segue.sourceViewController;
    NSString *firstName = editPlayerController.playerFistName;
    NSString *lastName = editPlayerController.playerLastName;
    NSNumber *number = editPlayerController.playerNumber;
    Player *newPlayer = [Player playerWithFirstName:firstName lastName:lastName number:number inManagedObjectContext:self.moc];
    Season *currentSeason = [[self.team.seasons allObjects] lastObject];
    [currentSeason addPlayersObject:newPlayer];
    //Refresh playersData
    self.playersArray = [currentSeason.players allObjects];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"playerSelected"]) {
        HSPlayerProfileViewController *playerProfileController = segue.destinationViewController;
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            UITableViewCell *cell = sender;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            Player *player = [self.playersArray objectAtIndex:indexPath.row];
            playerProfileController.player = player;
        }
    }
}

@end
