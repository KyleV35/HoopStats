//
//  Game+Create.m
//  HoopStats
//
//  Created by Kyle Vermeer on 3/12/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import "Game+Create.h"
#import "Season.h"
#import "Team.h"

@implementation Game (Create)

+(Game*)gameWithSeason:(Season*)season againstTeam:(Team*)opponent inManagedObjectContext:(NSManagedObjectContext*)context
{
    Game *game = nil;
    if (!game) {
        //Create Game
        game = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:context];
        game.season = season;
        game.teams = [NSSet setWithObjects:season.team,opponent, nil];
        game.date = [NSDate date];
    }
    return game;
}

@end
