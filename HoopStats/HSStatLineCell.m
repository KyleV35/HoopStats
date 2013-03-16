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
    int freeThrowsMade = 0;
    int freeThrowsAttempted = 0;
    int offensiveRebounds = 0;
    int defensiveRebounds = 0;
    int assists = 0;
    int steals = 0;
    int personalFouls = 0;
    int turnovers = 0;
    int gamesPlayed = [self.player.gameStatLines count];
    for (GameStatLine *statLine in self.player.gameStatLines) {
        totalCareerPoints += statLine.twoPointsMade.intValue*2 +statLine.threePointsMade.intValue*3 +statLine.onePointMade.intValue;
        fieldGoalsAttempted += statLine.twoPointsAttempted.intValue + statLine.threePointsAttempted.intValue;
        fieldGoalsMade += statLine.twoPointsMade.intValue + statLine.threePointsMade.intValue;
        threePointsMade += statLine.threePointsMade.intValue;
        threePointsAttempted += statLine.threePointsAttempted.intValue;
        freeThrowsMade += statLine.onePointMade.intValue;
        freeThrowsAttempted += statLine.onePointAttempted.intValue;
        offensiveRebounds  += statLine.offensiveRebounds.intValue;
        defensiveRebounds += statLine.defensiveRebounds.intValue;
        assists += statLine.assists.intValue;
        steals += statLine.steals.intValue;
        personalFouls += statLine.fouls.intValue;
        turnovers += statLine.turnovers.intValue;
    }
    if (self.statLineCellType == HSStatLineCellTypeTotal) {
        self.PTSLabel.text = [NSString stringWithFormat:@"%d",totalCareerPoints];
        self.GPLabel.text = [NSString stringWithFormat:@"%d", gamesPlayed];
        self.FGAFGMLabel.text = [NSString stringWithFormat:@"%d-%d", fieldGoalsMade,fieldGoalsAttempted];
        self.FGPercentLabel.text = [NSString stringWithFormat:@"%.1f%%",100.0f*(float)fieldGoalsMade/(float)MAX(fieldGoalsAttempted,1)];
        self.ThreePAThreePMLabel.text = [NSString stringWithFormat:@"%d-%d", threePointsMade,threePointsAttempted];
        self.ThreePercentLabel.text = [NSString stringWithFormat:@"%.1f%%",100.0f*(float)threePointsMade/(float)MAX(threePointsAttempted,1)];
        self.FTAFTMLabel.text = [NSString stringWithFormat:@"%d-%d", freeThrowsMade, freeThrowsAttempted];
        self.FTPLabel.text = [NSString stringWithFormat:@"%.1f%%", 100.0f *(float)freeThrowsMade/(float)MAX(freeThrowsAttempted,1)];
        self.ORLabel.text = [NSString stringWithFormat:@"%d",offensiveRebounds];
        self.DRLabel.text = [NSString stringWithFormat:@"%d",defensiveRebounds];
        self.REBLabel.text = [NSString stringWithFormat:@"%d",offensiveRebounds + defensiveRebounds];
        self.ASTLabel.text = [NSString stringWithFormat:@"%d",assists];
        self.STLLabel.text = [NSString stringWithFormat:@"%d",steals];
        self.PFLabel.text = [NSString stringWithFormat:@"%d",personalFouls];
        self.TOLabel.text = [NSString stringWithFormat:@"%d",turnovers];
    } else {
        self.PTSLabel.text = [NSString stringWithFormat:@"%.1f",(float)totalCareerPoints/gamesPlayed];
        self.GPLabel.text = [NSString stringWithFormat:@"%d", gamesPlayed];
        self.FGAFGMLabel.text = [NSString stringWithFormat:@"%.1f-%.1f", (float)fieldGoalsMade/gamesPlayed,(float)fieldGoalsAttempted/gamesPlayed];
        self.FGPercentLabel.text = [NSString stringWithFormat:@"%.1f%%",100.0f*(float)fieldGoalsMade/(float)MAX(fieldGoalsAttempted,1)];
        self.ThreePAThreePMLabel.text = [NSString stringWithFormat:@"%.1f-%.1f", (float)threePointsMade/gamesPlayed,(float)threePointsAttempted/gamesPlayed];
        self.ThreePercentLabel.text = [NSString stringWithFormat:@"%.1f%%",100.0f*(float)threePointsMade/(float)MAX(threePointsAttempted,1)];
        self.FTAFTMLabel.text = [NSString stringWithFormat:@"%.1f-%.1f", (float)freeThrowsMade/gamesPlayed, (float)freeThrowsAttempted/gamesPlayed];
        self.FTPLabel.text = [NSString stringWithFormat:@"%.1f%%", 100.0f *(float)freeThrowsMade/(float)MAX(freeThrowsAttempted,1)];
        self.ORLabel.text = [NSString stringWithFormat:@"%.1f",(float)offensiveRebounds/gamesPlayed];
        self.DRLabel.text = [NSString stringWithFormat:@"%.1f",(float)defensiveRebounds/gamesPlayed];
        self.REBLabel.text = [NSString stringWithFormat:@"%.1f",(float)(offensiveRebounds + defensiveRebounds)/gamesPlayed];
        self.ASTLabel.text = [NSString stringWithFormat:@"%.1f",(float)assists/gamesPlayed];
        self.STLLabel.text = [NSString stringWithFormat:@"%.1f",(float)steals/gamesPlayed];
        self.PFLabel.text = [NSString stringWithFormat:@"%.1f",(float)personalFouls/gamesPlayed];
        self.TOLabel.text = [NSString stringWithFormat:@"%.1f",(float)turnovers/gamesPlayed];
    }
}

@end
