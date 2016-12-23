//
//  AppHelper.h
//  HappyPenguin
//
//  Created by zhuangyihang on 1/8/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DateFormat) {
    DateFormatFullDateWithTime,//YYYY-MM-dd HH:mm:ss
    DateFormatFullDate,//YYYY-MM-dd
};

typedef NS_ENUM(NSInteger, PictureType) {
    PictureType_Vip,//会员头像，会员照片墙
    PictureType_Goods,//销售图片
    PictureType_Calendar,//跟进图片
};
extern NSString *PictureTypeValue[];

@interface AppHelper : NSObject

+ (UIButton *)createVerticalButton:(UIImage *)image withTitle:(NSString *)title;

//当前屏幕宽度与指定机型的比例
+ (CGFloat)scaleForI5;
+ (CGFloat)scaleForI6P;
+ (CGFloat)scaleForI6;

//日期格式化
+ (NSDate *)getDateFromString:(NSString *)dateString withFormat:(DateFormat)format;
+ (NSString *)getStringFromDate:(NSDate *)date withFormat:(DateFormat)format;


//
+ (NSURL *)getImagePath:(NSString *)comp type:(PictureType)type;

//格式化短信模版信息
+ (NSString *)formatSms:(NSString *)sms name:(NSString *)name gender:(NSString *)gender day:(NSInteger)days;

+ (NSString *)getUniqueString;

@end
