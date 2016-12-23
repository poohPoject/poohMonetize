//
//  NSString+Common.h
//  club
//
//  Created by zhuangyihang on 12/16/15.
//  Copyright © 2015 zhuangyihang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString(Common)

- (CGFloat)getHeightWithWidth:(CGFloat)width withFont:(UIFont *)font;
- (CGFloat)getHeightWithWidth:(CGFloat)width withFont:(UIFont *)font withMaxLine:(NSInteger)line;

+ (NSString *)createGuid;

- (BOOL)validateEmail;
- (BOOL)validatePhone;

- (NSString *)urlencode;
- (NSString *)flattenHTML:(BOOL)trim;//去除html
- (NSString *)gbkUrlencode;


- (NSString *)hexStringFromString;

- (long)intFromString:(long)range;
- (BOOL) isEmpty;

-(NSArray*)getPagesRange:(UIFont*)font inRect:(CGRect)r; //分页

+(NSString*)getStringWithBaseUrl:(NSString*)para;

@end
