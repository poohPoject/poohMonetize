//
//  HttpError.h
//  club
//
//  Created by zhuangyihang on 1/18/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpError : NSObject

@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *errorMessage;

- (id)initWithNSError:(NSError *)error;

@end
