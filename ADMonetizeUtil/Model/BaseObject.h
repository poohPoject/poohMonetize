//
//  BaseObject.h
//  HappyPenguin
//
//  Created by zhuangyihang on 1/25/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "AppHelper.h"

@interface BaseObject : MTLModel<MTLJSONSerializing>

+(NSValueTransformer *)imageUrlJSONTransformer;

+(NSValueTransformer *)objectJSONTransformer:(Class)objectClass;
+(NSValueTransformer *)objectArrayJSONTransformer:(Class)objectClass;

+(NSValueTransformer *)numberJSONTransformer;
+(NSValueTransformer *)boolJSONTransformer;
+(NSValueTransformer *)dateStringJSONTransformer;
+(NSValueTransformer *)dateTimeStringJSONTransformer;
@end
