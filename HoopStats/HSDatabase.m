
//
//  HSDatabase.m
//  StanfordSportCoreData
//
//  Created by Kyle Vermeer on 2/25/13.
//  Copyright (c) 2013 Kyle Vermeer. All rights reserved.
//

#import "HSDatabase.h"

@interface HSDatabase()

@property (nonatomic) UIManagedDocument* managedDocument;

@end

@implementation HSDatabase

static HSDatabase* sharedInstance;

#define DATABASE_FILE_NAME @"managedDocumentDB"

/* Initialize shared instance with initialize, called once per class */
+(void)initialize
{
    static BOOL initialized = NO;
    if (!initialized) {
        initialized = YES;
        HSDatabase *database = [[HSDatabase alloc] init];
        sharedInstance = database;
    }
}

+(id)sharedInstance
{
    return sharedInstance;
}

-(id)init
{
    self = [super init];
    if (self) {
        NSURL* managedDocumentURL = [self getManagedDocumentURL];
        self.managedDocument = [[UIManagedDocument alloc] initWithFileURL:managedDocumentURL];
    }
    return self;
}

-(void)performWithDocument:(OnDocumentReady)onDocumentReady
{
    void (^OnDocumentDidLoad)(BOOL) = ^(BOOL success) {
        if (success) {
            onDocumentReady(self.managedDocument);
        } else {
            NSLog(@"Trouble opening the document at %@", self.managedDocument.fileURL);
            exit(1);
        }
    };
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.managedDocument.fileURL path]]) {
        [self.managedDocument saveToURL:self.managedDocument.fileURL
                forSaveOperation:UIDocumentSaveForCreating
               completionHandler:OnDocumentDidLoad];
    } else if (self.managedDocument.documentState == UIDocumentStateClosed) {
        [self.managedDocument openWithCompletionHandler:OnDocumentDidLoad];
    } else if (self.managedDocument.documentState == UIDocumentStateNormal) {
        OnDocumentDidLoad(YES);
    }
}

-(NSURL*)getManagedDocumentURL
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //Get URL for our cache directory
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL* documentsURL = urls[0];
    return [documentsURL URLByAppendingPathComponent:DATABASE_FILE_NAME];
}

@end
