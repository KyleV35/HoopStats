//
//  Season.h
//  HoopStats
//
//  Created by Kyle Vermeer on 3/12/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game, Player, Team;

@interface Season : NSManagedObject

@property (nonatomic, retain) Team *team;
@property (nonatomic, retain) NSSet *players;
@property (nonatomic, retain) Game *games;
@end

@interface Season (CoreDataGeneratedAccessors)

- (void)addPlayersObject:(Player *)value;
- (void)removePlayersObject:(Player *)value;
- (void)addPlayers:(NSSet *)values;
- (void)removePlayers:(NSSet *)values;

@end
