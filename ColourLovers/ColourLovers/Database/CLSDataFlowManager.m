//
//  DataFlowManager.m
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/13/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import "CLSDataFlowManager.h"
#import "CLSNetworkManager.h"
#import "CLSLover+Mapping.h"
#import "CLSColor+Mapping.h"
#import "CLSPalette+Mapping.h"
#import "CLSPattern+Mapping.h"

#import "CLSDataBaseManager.h"

static const NSUInteger kBatchSize = 100;

@interface CLSDataFlowManager ()

@property (nonatomic, strong) NSManagedObjectContext *mainContext;

//TODO: refactor this
@property (nonatomic, assign) BOOL updating;
@property (nonatomic, assign) BOOL updating1;
@property (nonatomic, assign) BOOL updating2;
@property (nonatomic, assign) BOOL updating3;

@end

@implementation CLSDataFlowManager

+ (instancetype)sharedManager {
    static CLSDataFlowManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)updateLoversWithOffset:(NSNumber *)offset {
    __block __weak typeof(self) weakSelf = self;
    if (self.updating) {
        return;
    }
    self.updating = YES;
    
    [CLSNetworkManager getLoversNumber:@(kBatchSize)
                             andOffset:offset
                 withCompletionHandler:^(NSArray *resultArray, NSError *error) {
                     if ([resultArray count]) {
                         
                         [weakSelf handleResultsArray:resultArray
                                              ofClass:[CLSLover class]
                                       withUniquePath:@"userName"
                                withCompletionHandler:nil];
                     }
                     weakSelf.updating = NO;
                 }];
}

- (void)updateDataForUserName:(NSString *)userName withOffset:(NSNumber *)offset {
    NSManagedObjectID *loverID = [self loverWithName:userName];
    __block __weak typeof(self) weakSelf = self;
    
    if (!self.updating1) {
        self.updating1 = YES;
        
        [CLSNetworkManager getColorsForLover:userName
                                      number:@(kBatchSize)
                                   andOffset:offset
                       withCompletionHandler:^(NSArray *resultArray, NSError *error) {
                           if ([resultArray count]) {
                               [weakSelf handleBaseModelArray:loverID
                                                  resultArray:resultArray
                                                        class:[CLSColor class]];
                           }
                           weakSelf.updating1 = NO;
                       }];
    }
    
    if (!self.updating2) {
        self.updating2 = YES;
        
        [CLSNetworkManager getPalettesForLover:userName
                                        number:@(kBatchSize)
                                     andOffset:offset
                         withCompletionHandler:^(NSArray *resultArray, NSError *error) {
                             if ([resultArray count]) {
                                 
                                 [weakSelf handleBaseModelArray:loverID
                                                    resultArray:resultArray
                                                          class:[CLSPalette class]];
                             }
                             weakSelf.updating2 = NO;
                         }];
    }
    
    if (!self.updating3) {
        self.updating3 = YES;
        
        [CLSNetworkManager getPatternsForLover:userName
                                        number:@(kBatchSize)
                                     andOffset:offset
                         withCompletionHandler:^(NSArray *resultArray, NSError *error) {
                             if ([resultArray count]) {
                                 
                                 [weakSelf handleBaseModelArray:loverID
                                                    resultArray:resultArray
                                                          class:[CLSPattern class]];
                             }
                             weakSelf.updating3 = NO;
                         }];
    }
}

- (NSManagedObjectID *)loverWithName:(NSString *)userName {
    NSManagedObjectContext *context = [[CLSDataBaseManager sharedManager] createTemporaryContext];    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CLSLover"];
    request.predicate = [NSPredicate predicateWithFormat:@"userName == %@", userName];
    NSError *existingEntityError = nil;
    NSArray *existing = [context executeFetchRequest:request error:&existingEntityError];
    NSAssert(existingEntityError == nil, @"Search for existing : %@", existingEntityError);
    
    NSManagedObject *object = nil;
    if (existing.count > 0) {
        object = [existing firstObject];
    }
    return object.objectID;
}

- (void)handleBaseModelArray:(NSManagedObjectID *)loverID
                 resultArray:(NSArray *)resultArray
                       class:(Class)class {
    [self handleResultsArray:resultArray
                     ofClass:class
              withUniquePath:@"url"
       withCompletionHandler:^(NSArray *modelIdsArray, NSError *error) {
           NSManagedObjectContext *context = [[CLSDataBaseManager sharedManager] createTemporaryContext];
           [context performBlock:^{
               
               CLSLover *lover = (CLSLover*)[context objectWithID:loverID];
               for (NSManagedObjectID *modelID in modelIdsArray) {
                   CLSBaseEntity *model = (CLSBaseEntity *)[context objectWithID:modelID];
                   model.lover = lover;
               }
               NSError *saveError = nil;
               if ([context hasChanges] && ![context save:&saveError]) {
                   NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
               }
           }];
       }];
}

- (void)handleResultsArray:(NSArray *)resultArray
                   ofClass:(Class)class
            withUniquePath:(NSString *)path
     withCompletionHandler:(void (^)(NSArray *modelIdsArray,
                                     NSError *error)) completionHandler {
    NSManagedObjectContext *context = [[CLSDataBaseManager sharedManager] createTemporaryContext];
    [context performBlock:^{
        
        NSMutableArray *objects = [NSMutableArray array];
        
        for (NSDictionary *dict in resultArray) {
            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(class)];
            if (path) {
                request.predicate = [NSPredicate predicateWithFormat:@"%K == %@", path, dict[path]];
            }
            NSError *existingEntityError = nil;
            NSArray *existing = [context executeFetchRequest:request error:&existingEntityError];
            NSAssert(existingEntityError == nil, @"Search for existing : %@", existingEntityError);
            
            NSManagedObject *object = nil;
            if (existing.count == 1) {
                object = [existing firstObject];
            } else {
                object = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(class)
                                                       inManagedObjectContext:context];
            }
            NSAssert(existing.count < 2, @"Objects with same 'unique' ID exists!");
            if ([object respondsToSelector:@selector(populateWithDictionary:)]) {
                [object performSelector:@selector(populateWithDictionary:) withObject:dict];
            }
            [objects addObject:object];
        }
        
        NSError *saveError = nil;
        
        if ([context hasChanges] && ![context save:&saveError]) {
            NSLog(@"Error saving context.");
        }
        
        NSAssert(saveError == nil, @"Save main Context : %@", saveError);
        NSArray *ids = [objects valueForKey:@"objectID"];
        if (completionHandler) {
            completionHandler(ids, saveError);
        }
    }];
}

@end
