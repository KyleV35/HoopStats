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
#import "HSEditPlayerViewController.h"
#import "HSPhotoManager.h"

@interface HSPlayerProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *playerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableViewTotal;
@property (weak, nonatomic) IBOutlet UITableView *tableViewAverage;

@end

@implementation HSPlayerProfileViewController

-(void)setPlayer:(Player *)player
{
    _player = player;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshDisplay];
    [self.tableViewTotal registerNib:[UINib nibWithNibName:@"HSStatLineCell" bundle:nil] forCellReuseIdentifier:@"StatLineCell"];
    [self.tableViewAverage registerNib:[UINib nibWithNibName:@"HSStatLineCell" bundle:nil] forCellReuseIdentifier:@"StatLineCell"];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StatLineCell";
    HSStatLineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell) {
        if ([tableView isEqual:self.tableViewTotal]) {
            cell.statLineCellType = HSStatLineCellTypeTotal;
        } else {
            cell.statLineCellType = HSStatLineCellTypeAverage;
        }
        cell.player = self.player;
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (IBAction)editButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"editPlayer" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editPlayer"]) {
        HSEditPlayerViewController *editPlayerController = segue.destinationViewController;
        editPlayerController.player = self.player;
        editPlayerController.currentPlayerImage = self.playerImageView.image;
    }
}

-(IBAction)editCancelled:(UIStoryboardSegue*)segue
{
    //Do nothing
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)editAccepted:(UIStoryboardSegue*)segue
{
    //Make changes to team
    HSEditPlayerViewController *editPlayerController = segue.sourceViewController;
    NSString *firstName = editPlayerController.playerFistName;
    NSString *lastName = editPlayerController.playerLastName;
    NSNumber *number = editPlayerController.playerNumber;
    self.player.firstName = firstName;
    self.player.lastName = lastName;
    self.player.jerseyNumber = number;
    if (editPlayerController.imageWasChanged) {
        [self saveImage:editPlayerController.newPlayerImage];
    } else {
        [self refreshDisplay];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.moc save:nil];
}

-(void)refreshDisplay
{
    self.title = [self.player description];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",self.player.firstName,self.player.lastName];
    self.numberLabel.text = self.player.jerseyNumber.stringValue;
    Team *currentTeam = self.player.team;
    self.teamLabel.text = [NSString stringWithFormat:@"%@ %@",currentTeam.location, currentTeam.teamName];
    HSPhotoManager* photoManager = [HSPhotoManager sharedInstance];
    Player* player = self.player;
    dispatch_queue_t photoQueue = dispatch_queue_create("Photo Retrieval", NULL);
    //[self.spinner startAnimating];
    dispatch_async(photoQueue, ^{
        NSData *imageData= [photoManager dataForPhotoInStorageForPlayer:self.player];
        UIImage *image = nil;
        if (!imageData) {
            // No photo for player
            image= [UIImage imageNamed:@"noImage.jpg"];
        } else {
            // Photo was cached, read from disk
            imageData = [photoManager dataForPhotoInStorageForPlayer:self.player];
            image = [[UIImage alloc] initWithData:imageData];
        }
        
        //Check to make sure the user is still waiting for the image to download
        if (player == self.player) {
            
            // Dispatch to main thread to do UIKit work
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    self.playerImageView.image = image;
                    // Maybe adjust size
                    //self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
                }
                //[self.spinner stopAnimating];
            });
        }
    });
}
                       

-(void)saveImage:(UIImage*)image;
{
    HSPhotoManager* photoManager = [HSPhotoManager sharedInstance];
    dispatch_queue_t photoSaveQueue = dispatch_queue_create("Photo Saving", NULL);
    //[self.spinner startAnimating];
    dispatch_async(photoSaveQueue, ^{
        BOOL successfulSave = [photoManager putPhotoDataInCache:UIImageJPEGRepresentation(image, 1.0f) ForPlayer:self.player];
        if (successfulSave) {
            NSLog(@"Successful Save");
        } else {
            NSLog(@"Unsuccessful Save");
        }
        dispatch_async(dispatch_get_main_queue(),^{
            if (self) {
                [self refreshDisplay];
            }
        });
    });

}


@end
