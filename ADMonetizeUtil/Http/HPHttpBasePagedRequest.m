//
//  HPHttpBasePagedRequest.m
//  HappyPenguin
//
//  Created by zhuangyihang on 1/29/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import "HPHttpBasePagedRequest.h"

@implementation HPHttpBasePagedRequest

- (id)init{
    self = [super init];
    if (self) {
        self.queryBegin = 1;
        self.queryNumber = 10;
    }
    return self;
}

- (void)reset{
    self.queryBegin = 1;
    self.queryNumber = 10;
    self.response = nil;
}

- (HttpBaseResponse *)getResponse:(id)data{
    
    NSArray *result = [[ObjectBuilder builder] objectArrayFromJSON:data className:[self objectNameOfArray]];
    if (self.response == nil) {
        self.response = [[HPHttpBasePagedResponse alloc]init];
    }
    
    [self.response.results addObjectsFromArray:result];
    if (result.count==self.queryNumber) {
        self.response.hasMore = YES;
    }else{
        self.response.hasMore = NO;
    }
    
    return self.response;
}

- (void)pullRefresh{
    self.queryBegin = 1;
    [self send];
}
- (void)loadMore{
    self.queryBegin = self.response.results.count/self.queryNumber+1;
    [self send];
}

- (NSString *)objectNameOfArray{
    return @"";
}

- (NSDictionary *)prepareForParameter{
    return @{@"page":@(self.queryBegin),@"limit":@(self.queryNumber)};
}

@end

@implementation HPHttpBasePagedResponse

- (id)init{
    self = [super init];
    if (self) {
        self.results = [NSMutableArray array];
    }
    return self;
}

@end
