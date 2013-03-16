//
//  HSStatLineCell.h
//  HoopStats
//
//  Created by Kyle Vermeer on 3/15/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

typedef enum {
    HSStatLineCellTypeTotal,
    HSStatLineCellTypeAverage
} HSStatLineCellType;

@interface HSStatLineCell : UITableViewCell

@property (strong, nonatomic) Player *player;
@property (nonatomic) HSStatLineCellType statLineCellType;

@end
