//
//  Team.h
//  HoopStats
//
//  Created by Kyle Vermeer on 3/12/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game, Season;

@interface Team : NSManagedObject

@property (nonatomic, retain) NSString * teamName;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) Game *games;
@property (nonatomic, retain) NSSet *seasons;
@end

@interface Team (CoreDataGeneratedAccessors)

- (void)addSeasonsObject:(Season *)value;
- (void)removeSeasonsObject:(Season *)value;
- (void)addSeasons:(NSSet *)values;
- (void)removeSeasons:(NSSet *)values;

@end
