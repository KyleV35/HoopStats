//
//  HSGameViewController.m
//  HoopStats
//
//  Created by Kyle Vermeer on 3/7/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import "HSGameViewController.h"
#import "HSAddStatViewController.h"

#define NUM_RECENT_HIGHLIGHTS 3

@interface HSGameViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIPopoverController *popover;
@property (weak, nonatomic) IBOutlet UITableView *RecentHighlightsTableView;
@property (strong, nonatomic) NSArray* recentHighlights;
@property (weak, nonatomic) IBOutlet UILabel *leftTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTeamLabel;

@end

@implementation HSGameViewController

-(void)viewDidLoad
{
    self.recentHighlights = @[@"3pt made - 32 Spurs",@"Foul - 45 Timberwolves", @"Steal - 33 Spurs"];
    self.leftTeamLabel.text = self.leftTeam.teamName;
}

- (IBAction)playerButtonPushed:(UIButton *)sender
{
    self.popover = [[UIPopoverController alloc] initWithContentViewController:[[HSAddStatViewController alloc] init]];
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


@end
