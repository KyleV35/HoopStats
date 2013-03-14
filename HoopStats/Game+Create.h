//
//  Game+Create.h
//  HoopStats
//
//  Created by Kyle Vermeer on 3/12/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import "Game.h"

@interface Game (Create)

+(Game*)gameWithSeason:(Season*)season againstTeam:(Team*)opponent inManagedObjectContext:(NSManagedObjectContext*)context;

@end
