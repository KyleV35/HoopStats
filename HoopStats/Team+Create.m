//
//  Team+Create.m
//  HoopStats
//
//  Created by Kyle Vermeer on 3/12/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import "Team+Create.h"

@implementation Team (Create)

+(Team*)teamWithName:(NSString*)name location:(NSString*)location inManagedObjectContext:(NSManagedObjectContext*)context
{
    Team *team = nil;
    if (!team) {
        //Create Team
        team = [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:context];
        team.teamName = name;
        team.location = location;
    }
    return team;
}

@end
