//
//  AdNetConfigManager.m
//  poohMonetize
//
//  Created by 柯尔祥 on 2016/12/22.
//  Copyright © 2016年 com.kat. All rights reserved.
//

#import "AdNetConfigManager.h"

#import "ObjectBuilder.h"
#import "NSDate+Category.h"
#import "PoohMonetizePublic.h"
static NSString *SYSTEM_NET_CONFIG = @"SYSTEM_NET_CONFIG";

@interface AdNetConfigManager()

@property (nonatomic, strong) AdNetConfigObject *nSysConfig;


@end

@implementation AdNetConfigManager


+(AdNetConfigManager*) sharedInstance
{
    WS(ws);
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[ws alloc] init];
    });
    return _sharedObject;
}


//获取当前配置
- (AdNetConfigObject *)getConfig{
    if (self.nSysConfig) {
        return self.nSysConfig;
    }
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:SYSTEM_NET_CONFIG];
    if (dic) {
        self.nSysConfig = [[ObjectBuilder builder]objectFromJSON:dic className:@"AdNetConfigObject"];
    }else{
        AdNetConfigObject* config = [[AdNetConfigObject alloc]init];
        [self saveConfig:config];//初始化配置
    }
    
    return self.nSysConfig;
}

//保存当前配置
- (void)saveConfig:(AdNetConfigObject *)config{
    if (config==nil) {
        return;
    }
    self.nSysConfig = config;
    NSDictionary *dic = [[ObjectBuilder builder] JSONDictionaryFromObject:config];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:SYSTEM_NET_CONFIG];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//请求获取网络系统配置
-(void)refreshAdNetConfig{
    
    WS(ws);
    HttpAdNetConfigRequest* request = [[HttpAdNetConfigRequest alloc]init];
    request.responseBlock = ^(HttpAdNetConfigResponse *response, HttpError *error){
        if (error) {
            NSLog(@"refreshAdNetConfig Error:%@",error.errorMessage);
        }else{
            NSLog(@"refreshAdNetConfig succ:%@",response.config);
            [ws saveConfig:response.config];
        }
    };
    [request send];
}

@end
