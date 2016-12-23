//
//  HttpError.m
//  club
//
//  Created by zhuangyihang on 1/18/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import "HttpError.h"

@implementation HttpError

-(id)init{
    if (self = [super init]) {
        self.errorCode = @"";
        self.errorMessage = @"";
    }
    return self;
}

- (id)initWithNSError:(NSError *)error{
    self = [super init];
    if (self) {
        self.errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
        self.errorMessage = error.localizedDescription;
    }
    return self;
}
@end
