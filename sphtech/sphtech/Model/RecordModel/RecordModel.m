//
//  RecordModel.m
//  sphtech
//
//  Created by Michael Ugale on 1/26/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "RecordModel.h"

@interface RecordModel()

@property (readwrite, nonatomic, strong) NSManagedObjectModel         *managedObjectModel;
@property (readwrite, nonatomic, strong) NSManagedObjectContext       *managedObjectContext;
@property (readwrite, nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSURL *applicationDocumentsDirectory;

@end

@implementation RecordModel

static RecordModel *manager     = nil;

+ (RecordModel *)sharedManager
{
    @synchronized(self) {
        if (!manager) {
            manager = (RecordModel *)[[self alloc] init];
        }
    }
    return manager;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:DEFAULT_DATABASE_NAME withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        if (self.persistentStoreCoordinator) {
            _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
            [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
        }
    }
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (!_persistentStoreCoordinator) {
        NSURL *storeURL = [self.applicationDocumentsDirectory URLByAppendingPathComponent:DEFAULT_DATABASE_FILENAME];
        
        NSError *error = nil;
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        
        NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES};
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
            [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        }
    }
    return _persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory {
    if (!_applicationDocumentsDirectory) {
        _applicationDocumentsDirectory = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
    }
    return _applicationDocumentsDirectory;
}

#pragma mark INSERT methods

- (void) insertItem:(RecordsManager *)record
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newDevice      = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_RECORD
                                                                    inManagedObjectContext:context];
    
    NSString *temp = [record.recordQuarter substringToIndex:[record.recordQuarter length]-1];
    [newDevice setValue:temp                        forKey:@"id"];
    [newDevice setValue:record.recordQuarter        forKey:@"quarter"];
    [newDevice setValue:record.recordVolume         forKey:@"volume"];
    
    NSLog(@"temp: %@",temp);
    SPLOG_DEBUG(@"recordQuarter: %@", record.recordQuarter);
    SPLOG_DEBUG(@"recordVolume: %@", record.recordVolume);
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        SPLOG_DEBUG(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

#pragma mark FETCH methods

- (NSMutableArray *) getAllItems
{
    NSManagedObjectContext *managedObjectContext    = [self managedObjectContext];
    NSFetchRequest *fetchRequest                    = [[NSFetchRequest alloc] initWithEntityName:ENTITY_RECORD];
    NSMutableArray *listItems                       = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
//    SPLOG_DEBUG(@"SELECT FROM: %@ - RESULT: %@", ENTITY_RECORD, listItems);
    
    return listItems;
}

- (NSMutableArray *) getItemByID:(NSString*)itemID
{
    NSPredicate *predicate                          = [NSPredicate predicateWithFormat:@"(id = %@)", itemID];
    NSManagedObjectContext *managedObjectContext    = [self managedObjectContext];
    NSFetchRequest *fetchRequest                    = [[NSFetchRequest alloc] initWithEntityName:ENTITY_RECORD];
    [fetchRequest setPredicate:predicate];
    NSMutableArray *listItems                       = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
//    SPLOG_DEBUG(@"SELECT FROM: %@ - RESULT: %@", ENTITY_RECORD, listItems);

    return listItems;    
}

- (Boolean) checkIfExist:(NSString*) itemID
{
    NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"(quarter = %@)", itemID];
    NSManagedObjectContext *managedObjectContext    = [self managedObjectContext];
    NSFetchRequest *fetchRequest                    = [[NSFetchRequest alloc] initWithEntityName:ENTITY_RECORD];
    [fetchRequest setPredicate:predicate];
    NSMutableArray *getItems                        = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    if ([getItems count] != 0) {
        return YES;
    } else {
        return NO;
    }
}

- (Boolean) checkIfExistAndDelete:(NSString*) itemID
{
    NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"(id = %@)", itemID];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [self.managedObjectContext setUndoManager:nil];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_RECORD inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    [fetchRequest setIncludesPropertyValues:NO];
    [fetchRequest setFetchLimit:1000]; // you can change this number if you want
    NSError *error;
    NSArray *items = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if ([items count] != 0) {
        while ([items count] > 0) {
            @autoreleasepool {
                for (NSManagedObject *item in items) {
                    [self.managedObjectContext deleteObject:item];
                }
                
                if (![self.managedObjectContext save:&error]) {
                    SPLOG_DEBUG(@"Error deleting %@ - error:%@",ENTITY_RECORD, error);
                }
            }
            items = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        }
        return YES;
    } else {
        return NO;
    }
}

#pragma mark DELETE methods

- (void) deleteAllItem
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [self.managedObjectContext setUndoManager:nil];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_RECORD inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setIncludesPropertyValues:NO];
    [fetchRequest setFetchLimit:1000]; // you can change this number if you want
    NSError *error;
    NSArray *items = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    while ([items count] > 0) {
        @autoreleasepool {
            for (NSManagedObject *item in items) {
                [self.managedObjectContext deleteObject:item];
            }
            
            if (![self.managedObjectContext save:&error]) {
                SPLOG_DEBUG(@"Error deleting %@ - error:%@",ENTITY_RECORD, error);
            }
        }
        items = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    }
}

@end
