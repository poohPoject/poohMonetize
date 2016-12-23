//
//  HttpBaseRequest.h
//  club
//
//  Created by zhuangyihang on 1/18/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpBaseResponse.h"
#import "HttpError.h"

typedef void (^HttpResponseBlock)(id response, HttpError *error);

@interface HttpUploadObject : NSObject

@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSString *name;

@end

@protocol HttpBaseRequestProtocol <NSObject>

- (HttpBaseResponse *)getResponse:(id)data;


/**
 *  获取参数
 *
 *  @ return
 */
- (NSDictionary *)getParameter;


/**
 *  获取上传的二进制数据
 *
 *  @ return
 */
- (HttpUploadObject *)getUploadData;

/**
 *  地址参数
 *
 *  @ return
 */
- (NSString *)getPathComponent;

@end


typedef void (^HttpResponse)(HttpBaseResponse *response, HttpError *error);

@interface HttpBaseRequest : NSObject<HttpBaseRequestProtocol>

@property (nonatomic,strong) HttpResponseBlock responseBlock;

- (void)send;
- (void)post;
- (NSString *)getRequestUrl;


/**
 *  批量上传代码
 *
 *  @ param images
 *  @ param completion
 */
+ (void)batchUpload:(NSArray *)images completion:(HttpResponseBlock)completion;
@end
