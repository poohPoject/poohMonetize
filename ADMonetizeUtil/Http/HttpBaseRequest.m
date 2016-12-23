//
//  HttpBaseRequest.m
//  club
//
//  Created by zhuangyihang on 1/18/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import "HttpBaseRequest.h"
#import "HttpClient.h"
#import "NSObject+Common.h"


@implementation HttpUploadObject



@end

@implementation HttpBaseRequest

- (void)send{
    [[HttpClient client] get:self completion:^(id data, NSError *error) {
        NSLog(@"api data:%@",data);

        if (error) {
            HttpError *err = [[HttpError alloc] init];
            err.errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
            err.errorMessage = error.localizedDescription;
            self.responseBlock(nil,err);
            
            NSLog(@"http error:%@",err.errorCode);
        }else{
            HttpBaseResponse *response = [self getResponse:data];
            self.responseBlock(response,nil);
         
          /*  NSInteger status = [[data objectForKey:@"showapi_res_code"] integerValue];
            if (status!=0) {//失败
                
                    HttpError *err = [[HttpError alloc] init];
                    err.errorCode = [NSString stringWithFormat:@"%ld",(long)status];
                    err.errorMessage = [data objectForKey:@"showapi_res_error"];
                    self.responseBlock(nil,err);
                    NSLog(@"api error:%@",err.errorMessage);
                
            }else{
                HttpBaseResponse *response = [self getResponse:[data objectForKey:@"showapi_res_body"]];
                self.responseBlock(response,nil);
            }*/
        }
    }];
}

- (void)post{
    [[HttpClient client] post:self completion:^(id data, NSError *error) {
        if (error) {
            HttpError *err = [[HttpError alloc] init];
            err.errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
            err.errorMessage = error.localizedDescription;
            self.responseBlock(nil,err);
            
            NSLog(@"http error:%@",err.errorCode);
        }else{
            
            NSInteger status = [[data objectForKey:@"STATUS"] integerValue];
            if (status!=0) {
                HttpError *err = [[HttpError alloc] init];
                err.errorCode = [NSString stringWithFormat:@"%ld",(long)status];
                err.errorMessage = [data objectForKey:@"msg"];
                self.responseBlock(nil,err);
                NSLog(@"api error:%@",err.errorMessage);
            }else{
                HttpBaseResponse *response = [self getResponse:[data objectForKey:@"MESSAGE"]];
                self.responseBlock(response,nil);
            }
        }
    }];
}

+ (void)batchUpload:(NSArray *)images completion:(HttpResponseBlock)completion{
    [NSObject runBlockAfterDelay:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) delay:0 block:^{
        NSMutableArray *array = [NSMutableArray array];
        __block HttpError *err = nil;
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        for (UIImage *image in images) {
            [[HttpClient client] upload:image completion:^(id data, NSError *error) {
                if (error) {
                    err = [[HttpError alloc] initWithNSError:error];
                }else{
                    NSInteger status = [[data objectForKey:@"status"] integerValue];
                    if (status==1) {
                        NSDictionary *d = [data objectForKey:@"data"];
                        NSString *url = [d objectForKey:@"content"];
                        if (url.length>0) {
                            [array addObject:url];
                        }
                    }else{
                        err = [[HttpError alloc] init];
                        err.errorCode = [NSString stringWithFormat:@"%ld",(long)status];
                        err.errorMessage = [data objectForKey:@"msg"];
                    }
                    
                }
                dispatch_semaphore_signal(sema);
            }];
            
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            
            if (err) {
                completion(nil,err);
                break;
            }
        }
        completion(array,nil);
    }];
}
- (NSString *)getRequestUrl{

    return @"";
}


#pragma mark - HttpBaseRequestProtocol
- (HttpBaseResponse *)getResponse:(id)data{
    return nil;
}

- (NSDictionary *)getParameter{
    return @{};
}

- (HttpUploadObject *)getUploadData{
    return [HttpUploadObject new];
}

- (NSString *)getPathComponent{
    NSLog(@"should be override");
    return @"";
}


@end
