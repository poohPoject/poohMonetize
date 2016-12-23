//
//  HPHttpBaseRequest.h
//  HappyPenguin
//
//  Created by zhuangyihang on 1/25/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import "HttpBaseRequest.h"

@interface HPHttpBaseRequest : HttpBaseRequest

//Should be Override
- (NSDictionary *)prepareForParameter;
- (NSString *)getAppType;
@end
