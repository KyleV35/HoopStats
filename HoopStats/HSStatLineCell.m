//
//  HSStatLineCell.m
//  HoopStats
//
//  Created by Kyle Vermeer on 3/15/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import "HSStatLineCell.h"
#import "GameStatLine.h"

@interface HSStatLineCell()

@property (strong, nonatomic) IBOutlet UILabel *GPLabel;
@property (weak, nonatomic) IBOutlet UILabel *FGAFGMLabel;
@property (weak, nonatomic) IBOutlet UILabel *FGPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *ThreePAThreePMLabel;
@property (weak, nonatomic) IBOutlet UILabel *ThreePercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *FTAFTMLabel;
@property (weak, nonatomic) IBOutlet UILabel *FTPLabel;
@property (weak, nonatomic) IBOutlet UILabel *ORLabel;
@property (weak, nonatomic) IBOutlet UILabel *DRLabel;
@property (weak, nonatomic) IBOutlet UILabel *REBLabel;
@property (weak, nonatomic) IBOutlet UILabel *ASTLabel;
@property (weak, nonatomic) IBOutlet UILabel *STLLabel;
@property (weak, nonatomic) IBOutlet UILabel *PFLabel;
@property (weak, nonatomic) IBOutlet UILabel *TOLabel;
@property (weak, nonatomic) IBOutlet UILabel *PTSLabel;

@end

@implementation HSStatLineCell

-(void)setPlayer:(Player *)player
{
    _player = player;
    [self setPoints];
}

-(void)setPoints
{
    int totalCareerPoints = 0;
    int fieldGoalsAttempted = 0;
    int fieldGoalsMade = 0;
    int threePointsMade = 0;
    int threePointsAttempted = 0;
    int gamesPlayed = [self.player.gameStatLines count];
    for (GameStatLine *statLine in self.player.gameStatLines) {
        totalCareerPoints += statLine.twoPointsMade.intValue*2 +statLine.threePointsMade.intValue*3 +statLine.onePointMade.intValue;
        fieldGoalsAttempted += statLine.twoPointsAttempted.intValue + statLine.threePointsAttempted.intValue;
        fieldGoalsMade += statLine.twoPointsMade.intValue + statLine.threePointsMade.intValue;
        threePointsMade += statLine.threePointsMade.intValue;
        threePointsAttempted = statLine.threePointsAttempted;
    }
    self.PTSLabel.text = [NSString stringWithFormat:@"%d",totalCareerPoints];
    self.GPLabel.text = [NSString stringWithFormat:@"%d", gamesPlayed];
    self.FGAFGMLabel.text = [NSString stringWithFormat:@"%d-%d", fieldGoalsMade,fieldGoalsAttempted];
    self.FGPercentLabel.text = [NSString stringWithFormat:@"%.1f%%",100.0f*(float)fieldGoalsMade/(float)fieldGoalsAttempted];
    self.ThreePAThreePMLabel.text = [NSString stringWithFormat:@"%d-%d", threePointsMade,threePointsAttempted];
    self.ThreePercentLabel.text = [NSString stringWithFormat:@"%.1f%%",100.0f*(float)threePointsMade/(float)threePointsAttempted];
}

@end
