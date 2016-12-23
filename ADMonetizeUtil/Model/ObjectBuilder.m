//
//  ObjectBuilder.m
// Doppio
//
//  Created by Christian Roman on 20/12/13.
//  Copyright (c) 2013 Christian Roman. All rights reserved.
//

#import "ObjectBuilder.h"
#import <Mantle/Mantle.h>
#import "JSONKit.h"

@implementation ObjectBuilder

+ (id)builder
{
    static dispatch_once_t onceQueue;
    static ObjectBuilder *__builder = nil;
    dispatch_once(&onceQueue, ^{
        __builder = [[ObjectBuilder alloc] init];
    });
    
    return __builder;
}

- (id)objectFromJSON:(NSDictionary *)JSON className:(NSString *)className
{
    NSParameterAssert(className);
    
    NSError *error = nil;
    id model = [MTLJSONAdapter modelOfClass:NSClassFromString(className) fromJSONDictionary:JSON error:&error];
    
    if (!error) {
        return model;
    } else {
        NSLog(@"%@",error);
        return nil;
    }
}

- (id)objectArrayFromJSON:(NSArray *)JSON className:(NSString *)className{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *objectJSON in JSON) {
        NSError *err = nil;
        id object = [MTLJSONAdapter modelOfClass:NSClassFromString(className)
                              fromJSONDictionary:objectJSON
                                           error:&err];
        if (err==nil) {
            [array addObject:object];
        }else{
            NSLog(@"%@",err);
        }
    }
    return array;
}

- (id)collectionFromJSON:(NSDictionary *)JSON className:(NSString *)className
{
    NSParameterAssert(className);
    
    if ([JSON isKindOfClass:[NSArray class]]) {
        
        NSValueTransformer *valueTransformer = [MTLJSONAdapter arrayTransformerWithModelClass:NSClassFromString(className)];
        NSArray *collection = [valueTransformer transformedValue:JSON];
        return collection;
        
    }
    return nil;
}

- (NSDictionary *)JSONDictionaryFromObject:(id)object{
    NSError *err = nil;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:object error:&err];
    if (err) {
        NSLog(@"%@转化JSON错误,%@",object, err);
        return nil;
    }
    return dic;
}

- (NSString *)JSONStringFromObject:(id)object{
    
    NSDictionary *dic = [self JSONDictionaryFromObject:object];
    return [dic JSONString];
}

- (id)JSONArrayFromObjects:(id)objects{
    
    NSMutableArray *array = [NSMutableArray array];
    for (id object in objects) {
        NSError *err = nil;
        NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:object error:&err];
        if (err) {
            NSLog(@"%@转化JSON错误,%@",object, err);
        }
        else{
            [array addObject:dic];
        }
    }
    return array;
}


@end
