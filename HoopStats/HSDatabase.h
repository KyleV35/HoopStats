//
//  HSDatabase.h
//  StanfordSportCoreData
//
//  Created by Kyle Vermeer on 2/25/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void (^OnDocumentReady) (UIManagedDocument *document);

@interface HSDatabase : NSObject

+(id) sharedInstance;
-(void)performWithDocument:(OnDocumentReady)onDocumentReady;

@end
