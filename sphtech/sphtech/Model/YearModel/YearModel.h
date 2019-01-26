//
//  YearModel.h
//  sphtech
//
//  Created by Michael Ugale on 1/26/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

//Resources
#import "Constant.h"

//Objects
#import "YearManager.h"

@interface YearModel : NSObject

@property (readonly, nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (readonly, nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (readonly, nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (YearModel *)sharedManager;

#pragma mark INSERT methods
- (void) insertItem:(NSString *)year;

#pragma mark FETCH methods
- (NSMutableArray *) getAllItems;
- (Boolean) checkIfExist:(NSString*) itemID;
- (Boolean) checkIfExistAndDelete:(NSString*) itemID;

#pragma mark DELETE methods
- (void) deleteAllItem;

@end
