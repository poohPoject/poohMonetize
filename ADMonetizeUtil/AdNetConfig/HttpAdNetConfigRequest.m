//
//  HttpAdNetConfigRequest.m
//  poohMonetize
//
//  Created by 柯尔祥 on 2016/12/22.
//  Copyright © 2016年 com.kat. All rights reserved.
//

#import "HttpAdNetConfigRequest.h"

@implementation HttpAdNetConfigRequest

-(NSString *)getRequestUrl{//返回url
    
    return @"http://kat.familyke.com/KatGame/kesGame.json";
    
}

- (HttpBaseResponse *)getResponse:(id)data{
    HttpAdNetConfigResponse *response = [[HttpAdNetConfigResponse alloc] init];
    response.config = [[ObjectBuilder builder] objectFromJSON:data className:@"AdNetConfigObject"];
    return response;
}

@end



@implementation HttpAdNetConfigResponse


@end
