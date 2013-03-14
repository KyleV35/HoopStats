//
//  Season+Create.m
//  HoopStats
//
//  Created by Kyle Vermeer on 3/12/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import "Season+Create.h"

@implementation Season (Create)

+(Season*)seasonWithTeam:(Team *)team inManagedObjectContext:(NSManagedObjectContext *)context
{
    Season *season = nil;
    if (!season) {
        //Create Season
        season = [NSEntityDescription insertNewObjectForEntityForName:@"Season" inManagedObjectContext:context];
        season.team = team;
    }
    return season;

}

@end
