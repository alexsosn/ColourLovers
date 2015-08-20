//
//  CLSDataBaseManager.m
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/18/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import "CLSDataBaseManager.h"

@interface CLSDataBaseManager ()

@property (strong, nonatomic, readwrite) NSManagedObjectContext *mainContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;

@end

@implementation CLSDataBaseManager

+ (instancetype)sharedManager {
    static CLSDataBaseManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

#pragma mark - Contexts

- (NSManagedObjectContext *)createTemporaryContext {
    NSManagedObjectContext* fetchContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    fetchContext.parentContext = self.mainContext;
    fetchContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
    [fetchContext setRetainsRegisteredObjects:YES];
    return fetchContext;
}

- (NSManagedObjectContext *)mainContext {
    if (!_mainContext) {
        _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_mainContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
        _mainContext.mergePolicy = NSRollbackMergePolicy;
    }
    return _mainContext;
}

- (void)handleDidSaveNotification:(NSNotification *)notification {
    NSManagedObjectContext *context = self.mainContext;
    if (notification.object != context)
    {
        [context performBlock:^{
            [context mergeChangesFromContextDidSaveNotification:notification];
            NSError *error = nil;
            
            if ([context hasChanges] && ![context save:&error]) {
                NSLog(@"Error saving context.");
            }
            
            NSAssert(error == nil, @"Save main Context : %@", error);
        }];
    }
}

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.mainContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}

#pragma mark - Core Data stack

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ColourLovers" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ColourLovers.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

@end
