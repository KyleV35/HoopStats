//
//  Player.h
//  HoopStats
//
//  Created by Kyle Vermeer on 3/12/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GameStatLine, Season;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * jerseyNumber;
@property (nonatomic, retain) NSSet *gameStatLines;
@property (nonatomic, retain) NSSet *seasons;
@end

@interface Player (CoreDataGeneratedAccessors)

- (void)addGameStatLinesObject:(GameStatLine *)value;
- (void)removeGameStatLinesObject:(GameStatLine *)value;
- (void)addGameStatLines:(NSSet *)values;
- (void)removeGameStatLines:(NSSet *)values;

- (void)addSeasonsObject:(Season *)value;
- (void)removeSeasonsObject:(Season *)value;
- (void)addSeasons:(NSSet *)values;
- (void)removeSeasons:(NSSet *)values;

@end
