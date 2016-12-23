//
//  HttpAdNetConfigRequest.h
//  poohMonetize
//
//  Created by 柯尔祥 on 2016/12/22.
//  Copyright © 2016年 com.kat. All rights reserved.
//

#import "HPHttpBaseRequest.h"
#import "AdNetConfigObject.h"

@interface HttpAdNetConfigRequest : HPHttpBaseRequest

@end


@interface HttpAdNetConfigResponse : HttpBaseResponse

@property (nonatomic, strong) AdNetConfigObject *config;

@end
