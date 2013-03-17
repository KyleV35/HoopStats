//
//  HSGameListViewController.m
//  HoopStats
//
//  Created by Kyle Vermeer on 3/16/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import "HSGameListViewController.h"
#import "Game+Create.h"
#import "HSReviewGameViewController.h"

#define GAME_SELECTED_SEGUE @"gameSelected"
#define GAME_CELL @"Game Cell"

@interface HSGameListViewController ()

@property (strong, nonatomic) NSArray *gamesArray;

@end

@implementation HSGameListViewController

-(void)setTeam:(Team *)team
{
    _team = team;
    self.gamesArray = [team.games allObjects];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.gamesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = GAME_CELL;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Game *game = [self.gamesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [game description];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:GAME_SELECTED_SEGUE]) {
        HSReviewGameViewController *gameReviewController = segue.destinationViewController;
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            UITableViewCell *cell = sender;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            gameReviewController.game = [self.gamesArray objectAtIndex:indexPath.row];
        }
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
