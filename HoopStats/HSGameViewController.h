//
//  HSGameViewController.h
//  HoopStats
//
//  Created by Kyle Vermeer on 3/7/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Team.h"

@interface HSGameViewController : UIViewController

@property (strong, nonatomic) Team *leftTeam;
@property (strong, nonatomic) Team *rightTeam;

@end
