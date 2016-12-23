//
//  ObjectBuilder.h
// Doppio
//
//  Created by Christian Roman on 20/12/13.
//  Copyright (c) 2013 Christian Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectBuilder : NSObject

+ (id)builder;
- (id)objectFromJSON:(NSDictionary *)JSON className:(NSString *)className;
- (id)objectArrayFromJSON:(NSArray *)JSON className:(NSString *)className;
- (id)collectionFromJSON:(NSDictionary *)JSON className:(NSString *)className;

- (NSString *)JSONStringFromObject:(id)object;
- (NSDictionary *)JSONDictionaryFromObject:(id)object;

- (id)JSONArrayFromObjects:(id)objects;


@end
