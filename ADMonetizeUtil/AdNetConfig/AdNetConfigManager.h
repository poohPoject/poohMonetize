//
//  AdNetConfigManager.h
//  poohMonetize
//
//  Created by 柯尔祥 on 2016/12/22.
//  Copyright © 2016年 com.kat. All rights reserved.
//

#import "BaseObject.h"
#import "HttpAdNetConfigRequest.h"
@interface AdNetConfigManager : BaseObject

+(AdNetConfigManager*) sharedInstance;

//请求获取网络系统配置
- (void)refreshAdNetConfig;
- (AdNetConfigObject *)getConfig;
- (void)saveConfig:(AdNetConfigObject *)config;

@end
