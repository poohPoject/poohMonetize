//
//  AppHelper.m
//  HappyPenguin
//
//  Created by zhuangyihang on 1/8/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import "AppHelper.h"
//#import "Director.h"

#import "NSString+Common.h"

static NSString *kDateFormatValue[] = {
    [DateFormatFullDateWithTime] = @"yyyy-MM-dd HH:mm:ss",
    [DateFormatFullDate] = @"yyyy-MM-dd",
};

NSString *PictureTypeValue[] = {
    [PictureType_Vip] = @"vippic",
    [PictureType_Goods] = @"goodspic",
    [PictureType_Calendar] = @"calendarpic",
};

static NSString *kDateFormatFullDateWithTime = @"yyyy-MM-dd HH:mm:ss";
static NSString *kDateFormatFullDate = @"yyyy-MM-dd";

@implementation AppHelper

+ (UIButton *)createVerticalButton:(UIImage *)image withTitle:(NSString *)title{
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b setImage:image forState:UIControlStateNormal];
    [b setTitle:title forState:UIControlStateNormal];
    
    CGFloat spacing = 6.0;
    CGSize imageSize = b.imageView.frame.size;
    b.titleEdgeInsets = UIEdgeInsetsMake(
                                         0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    CGSize titleSize = b.titleLabel.frame.size;
    b.imageEdgeInsets = UIEdgeInsetsMake(
                                         - (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);

    return b;
}

+ (CGFloat)scaleForI5{
    UIScreen *screen = [UIScreen mainScreen];
    return screen.bounds.size.width/320.0;
}

+ (CGFloat)scaleForI6P{
    UIScreen *screen = [UIScreen mainScreen];
    return screen.bounds.size.width/414.0;
}

+ (CGFloat)scaleForI6{
    UIScreen *screen = [UIScreen mainScreen];
    return screen.bounds.size.width/375.0;
}


+ (NSDate *)getDateFromString:(NSString *)dateString withFormat:(DateFormat)format{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:kDateFormatValue[format]];
    return [df dateFromString: dateString];
}
+ (NSString *)getStringFromDate:(NSDate *)date withFormat:(DateFormat)format{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:kDateFormatValue[format]];
    return [df stringFromDate:date];
}

/*
+ (NSURL *)getImagePath:(NSString *)comp type:(PictureType)type{
    if (comp.length>0) {
        UserObject *user = [[Director sharedInstance] getLoginUser];
        NSString *base = user.picIp;
        base = [base stringByAppendingPathComponent:PictureTypeValue[type]];
        base = [base stringByAppendingPathComponent:comp];
        return [NSURL URLWithString:base];
    }
    return [NSURL URLWithString:@""];
}

+ (NSString *)formatSms:(NSString *)sms name:(NSString *)name gender:(NSString *)gender day:(NSInteger)days{
    NSString *genderString = @"";
    if ([gender isEqualToString:@"男"]) {
        genderString = @"先生";
    }else if ([gender isEqualToString:@"女"]) {
        genderString = @"女士";
    }
    
    NSString *formatSms = [sms stringByReplacingOccurrencesOfString:@"{姓名}" withString:name];
    formatSms = [formatSms stringByReplacingOccurrencesOfString:@"{性别}" withString:genderString];
    formatSms = [formatSms stringByReplacingOccurrencesOfString:@"{N}" withString:[NSString stringWithFormat:@"%ld",(long)days]];

    
    UserObject *obj = [[Director sharedInstance] getLoginUser];
    formatSms = [formatSms stringByReplacingOccurrencesOfString:@"{店铺名称}" withString:obj.shopname];
    formatSms = [formatSms stringByReplacingOccurrencesOfString:@"{着装顾问}" withString:obj.nickname];
    
    formatSms = [formatSms stringByReplacingOccurrencesOfString:@"{短信签名}" withString:obj.smessage];
    
    return formatSms;
}
*/
+ (NSString *)getUniqueString{
    CFUUIDRef uuidRef =CFUUIDCreate(NULL);
    
    CFStringRef uuidStringRef =CFUUIDCreateString(NULL, uuidRef);
    
    CFRelease(uuidRef);
    
    NSString *uniqueId = (__bridge NSString *)uuidStringRef;
    return uniqueId;
}

@end
