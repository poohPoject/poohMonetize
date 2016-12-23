//
//  BaseObject.m
//  HappyPenguin
//
//  Created by zhuangyihang on 1/25/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import "BaseObject.h"
#import "AppHelper.h"

@implementation BaseObject

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{};
}

+(NSValueTransformer *)imageUrlJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *val, BOOL *success, NSError *__autoreleasing *error){
        return [NSURL URLWithString:val];
    } reverseBlock:^id(NSURL *value, BOOL *success, NSError *__autoreleasing *error) {
        return [value absoluteString];
    }];
}

+(NSValueTransformer *)objectJSONTransformer:(Class)objectClass{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *value, BOOL *success, NSError *__autoreleasing *error) {
        NSError *err = nil;
        id obj = [MTLJSONAdapter modelOfClass:objectClass fromJSONDictionary:value error:&err];
        if (err) {
            return nil;
        }
        return obj;
    } reverseBlock:^(id obj, BOOL *success, NSError *__autoreleasing *error){
        if (obj) {
            NSDictionary *jsonDictionary = [MTLJSONAdapter JSONDictionaryFromModel:obj error:nil];
            return jsonDictionary;
        }
        return [NSDictionary dictionary];
    }];
}

+(NSValueTransformer *)objectArrayJSONTransformer:(Class)objectClass{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *value, BOOL *success, NSError *__autoreleasing *error) {
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *child in value) {
            NSError *error = nil;
            id obj = [MTLJSONAdapter modelOfClass:objectClass fromJSONDictionary:child error:&error];
            if (obj==nil) {
                NSLog(@"%@",error);
            }else{
                [arr addObject:obj];
            }
        }
        return arr;
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSMutableArray *arr = [NSMutableArray array];
        for (id obj in value) {
            NSDictionary *jsonDictionary = [MTLJSONAdapter JSONDictionaryFromModel:obj error:nil];
            [arr addObject:jsonDictionary];
        }
        return arr;
    }];
}

+(NSValueTransformer *)numberJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *val, BOOL *success, NSError *__autoreleasing *error){
        return @([val integerValue]);
    } reverseBlock:^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%ld",[value integerValue]];
    }];
}

+(NSValueTransformer *)boolJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *val, BOOL *success, NSError *__autoreleasing *error){
        if ([val intValue]==0) {
            return @(NO);
        }else{
            return @(YES);
        }
    } reverseBlock:^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        return [value boolValue]?@"0":@"1";
    }];
}

+(NSValueTransformer *)dateStringJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *val, BOOL *success, NSError *__autoreleasing *error){
        NSDate *d = [AppHelper getDateFromString:val withFormat:DateFormatFullDate];
        return d;
    } reverseBlock:^(NSDate *value, BOOL *success, NSError *__autoreleasing *error){
        return [AppHelper getStringFromDate:value withFormat:DateFormatFullDate];
    }];
}

+(NSValueTransformer *)dateTimeStringJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *val, BOOL *success, NSError *__autoreleasing *error){
        NSDate *d = [AppHelper getDateFromString:val withFormat:DateFormatFullDateWithTime];
        return d;
    } reverseBlock:^(NSDate *value, BOOL *success, NSError *__autoreleasing *error){
        return [AppHelper getStringFromDate:value withFormat:DateFormatFullDateWithTime];
    }];
}
@end
