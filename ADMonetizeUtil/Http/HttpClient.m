//
//  HttpClient.m
//  club
//
//  Created by zhuangyihang on 1/18/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import "HttpClient.h"
#import "HttpBaseRequest.h"
#import <AFNetworking/AFNetworking.h>
#import "JSONKit.h"

@interface HttpClient()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@property (nonatomic, strong) NSString *baseUrl;

@end

@implementation HttpClient

+ (id)client{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

- (id)init{
    self = [super init];
    if (self) {
        self.sessionManager = [AFHTTPSessionManager manager];
        
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.sessionManager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    }
    return self;
}

- (void)setHttpBaseUrl:(NSString *)url{
    self.baseUrl = url;
}

- (void)post:(HttpBaseRequest *)request completion:(HttpClientResponse)completion{
  //  NSString *url = [self.baseUrl stringByAppendingPathComponent:[request getPathComponent]];
    NSString *url = [request getRequestUrl];

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[request getParameter]];
    NSLog(@"url:%@\nparam:%@",url,[request getParameter]);
    
    [self.sessionManager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        HttpUploadObject *fileData = [request getUploadData];
        if (fileData) {
            [formData appendPartWithFileData:fileData.data name:@"file" fileName:fileData.name mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil,error);
    }];
}

- (void)get:(HttpBaseRequest *)request completion:(HttpClientResponse)completion{
    //NSURL *url = [[NSURL URLWithString:self.baseUrl] URLByAppendingPathComponent:[request getPathComponent]];
    NSURL *url = [NSURL URLWithString:[request getRequestUrl]];

  //  NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[request getParameter]];
   // NSLog(@"url:%@\nparam:%@",url,[request getParameter]);
    NSLog(@"url:%@",url);
    [self.sessionManager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        completion(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil,error);
    }];
}

- (void)upload:(UIImage *)image completion:(HttpClientResponse)completion{
    NSString *url = [self.baseUrl stringByAppendingPathComponent:@"upload/index"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{}];
    
    [self.sessionManager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *fileData = UIImageJPEGRepresentation(image, 0.8);
        [formData appendPartWithFileData:fileData name:@"file" fileName:@"haha.jpg" mimeType:@"image/jpeg"];
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil,error);
    }];
}


- (void)download:(NSURL *)url completion:(HttpClientResponse)completion{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = url;
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) {
            NSLog(@"File downloaded ErrorMsg:%@",error.localizedDescription);
        }
        else{
            NSLog(@"File downloaded to: %@", filePath);
        }
        completion(filePath, error);
    }];
    [downloadTask resume];
}
@end
