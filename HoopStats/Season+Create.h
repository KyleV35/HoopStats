//
//  Season+Create.h
//  HoopStats
//
//  Created by Kyle Vermeer on 3/12/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import "Season.h"
#import "Team.h"

@interface Season (Create)

+(Season*)seasonWithTeam:(Team*)team inManagedObjectContext:(NSManagedObjectContext*)context;

@end
