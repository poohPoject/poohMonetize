//
//  HttpClient.h
//  club
//
//  Created by zhuangyihang on 1/18/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HttpBaseRequest;
@class HttpBaseResponse;
@class HttpError;
typedef void (^HttpClientResponse)(id data, NSError *error);


@interface HttpClient : NSObject

+ (id)client;

- (void)setHttpBaseUrl:(NSString *)url;

- (void)post:(HttpBaseRequest *)request completion:(HttpClientResponse)completion;
- (void)get:(HttpBaseRequest *)request completion:(HttpClientResponse)completion;

- (void)upload:(UIImage *)image completion:(HttpClientResponse)completion;


- (void)download:(NSURL *)url completion:(HttpClientResponse)completion;
@end
