//
//  VDManagedObjectContextManager.h
//  VD
//
//  Created by Evgeniy Tka4enko on 02.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSManagedObject+VDCoreData.h"

@interface VDManagedObjectContextManager : NSObject

+ (VDManagedObjectContextManager *)sharedInstanceWithModelName:(NSString *)modelName;
- (id)initWithModelName:(NSString *)_modelName;
- (NSManagedObjectContext *)managedObjectContextForCurrentThread;
- (void)deleteStore;
- (void)commit;
- (NSUInteger)pendingChangesCount;
- (BOOL)doesRequireMigration;

@end