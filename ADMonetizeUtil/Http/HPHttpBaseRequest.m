//
//  HPHttpBaseRequest.m
//  HappyPenguin
//
//  Created by zhuangyihang on 1/25/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import "HPHttpBaseRequest.h"
#import "NSDictionary+Common.h"
#import "NSDate+Category.h"
//#import "Director.h"

@implementation HPHttpBaseRequest

- (HttpBaseResponse *)getResponse:(id)data{
    return [[HttpBaseResponse alloc] init];
}

#pragma mark -
- (NSDictionary *)getParameter{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self getAuthenticationToken]];
    if ([self getAppType].length>0) {
     //   [dic setObject:[self getAppType] forKey:@"type"];
    }
    
  //  NSDictionary *baseParam = [[self prepareForParameter] merge:[self infoParameter]];
    NSDictionary *baseParam = [self prepareForParameter];
    return [dic merge:baseParam];
}

- (NSDictionary *)infoParameter{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return @{@"version":version,@"device":@"2"};
}

- (NSDictionary *)getAuthenticationToken{

    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString* date = [formatter stringFromDate:[NSDate new]];
    
    return @{@"showapi_appid":@"17381",
             @"showapi_sign" :@"185875716ec848b7a90f39be5c681b7c",
             @"showapi_timestamp":date
                };
}

- (NSString *)getPathComponent{
    return @"";
}


#pragma mark -
- (NSDictionary *)prepareForParameter{
    return @{};
}

- (NSString *)getAppType{
    return @"";
}
@end
