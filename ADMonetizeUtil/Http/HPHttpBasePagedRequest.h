//
//  HPHttpBasePagedRequest.h
//  HappyPenguin
//
//  Created by zhuangyihang on 1/29/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import "HPHttpBaseRequest.h"
#import "NSDictionary+Common.h"

@protocol HPHttpBasePagedRequestProtocol <NSObject>
@required
- (NSString *)objectNameOfArray;

@end

@class HPHttpBasePagedResponse;
@interface HPHttpBasePagedRequest : HPHttpBaseRequest<HPHttpBasePagedRequestProtocol>

@property (nonatomic, assign) NSInteger queryNumber;//每次接口返回数量
@property (nonatomic, assign) NSInteger queryBegin;//接口开始

@property (nonatomic, strong) HPHttpBasePagedResponse *response;


- (void)pullRefresh;
- (void)loadMore;

- (void)reset;
@end

@interface HPHttpBasePagedResponse : HttpBaseResponse

@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic, assign) BOOL hasMore;

@end
