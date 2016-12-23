//
//  NSString+Common.m
//  club
//
//  Created by zhuangyihang on 12/16/15.
//  Copyright © 2015 zhuangyihang. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString(Common)

- (CGFloat)getHeightWithWidth:(CGFloat)width withFont:(UIFont *)font{
    CGFloat height = MAXFLOAT;
    
    CGRect r = [self boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return r.size.height;
}

- (CGFloat)getHeightWithWidth:(CGFloat)width withFont:(UIFont *)font withMaxLine:(NSInteger)line{
    CGFloat lineHeight = font.lineHeight;
    
    CGFloat height = MAXFLOAT;
    if (line==0) {
        height = MAXFLOAT;
    }else{
        height = line * lineHeight;
    }
    
    CGRect r = [self boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return r.size.height;
}

+ (NSString *)createGuid{
    NSString *uuid = [[NSUUID UUID] UUIDString];
    return uuid;
}


- (BOOL)validateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)validatePhone{
    NSString *phoneRegex = @"1[3|5|7|8|][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (NSString *)urlencode {
    static CFStringRef charset = CFSTR("!@#$%&*()+'\";:=,/?[] ");
    CFStringRef str = (__bridge CFStringRef)self;
    CFStringEncoding encoding = kCFStringEncodingUTF8;
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, str, NULL, charset, encoding));
}

- (NSString *)gbkUrlencode {
    static CFStringRef charset = CFSTR("!@#$%&*()+'\";:=,/?[] ");
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    CFStringRef str = (__bridge CFStringRef)self;
    CFStringEncoding encoding = enc;
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, str, NULL, charset, encoding));
}

- (NSString *)flattenHTML:(BOOL)trim
{
    
    NSString* html = [self stringByReplacingOccurrencesOfString:@"<br><br>" withString:@"\n"];
    html = [html stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    
    html = [html stringByReplacingOccurrencesOfString:@"&nbsp;&nbsp;&nbsp;&nbsp;" withString:@"\n"];

    html = [html stringByReplacingOccurrencesOfString:@"◇↓頂◇↓点◇↓小◇↓说，www.23wx.com" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"&#13;" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"<br/>&#13;" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"<br/><br/>" withString:@"\n"];
    html = [html stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"\r" withString:@""];

    html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"&quot;" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"quot;" withString:@""];

  /*  NSString* html = [self stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
  
    html = [html stringByReplacingOccurrencesOfString:@"&#13;" withString:@""];
    
    html = [html stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    
    html = [html stringByReplacingOccurrencesOfString:@"&#13;" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"&quot;" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"quot;" withString:@""];*/

    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    
   // html = [html stringByReplacingOccurrencesOfString:@"\n" withString:@"<br /><br />"];

    
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}


- (NSString *)hexStringFromString{
    NSData *myD = [self dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}


- (long)intFromString:(long)range{
    
    NSString* str = self;
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);

    //最后一个字做图片
    const char *stringAsChar = [[str substringFromIndex:0] cStringUsingEncoding:enc];
    
    long ret = (long)stringAsChar[0];
    
    if (ret < 0) {
        ret = -ret;
    }
    return ret%range;
}
- (BOOL) isEmpty {
    
    if (!self) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

//对字符串进行分页
-(NSArray*)getPagesRange:(UIFont*)font inRect:(CGRect)r{
    
    //返回一个数组, 包含每一页的字符串开始点和长度(NSRange)
    NSMutableArray *ranges=[NSMutableArray array];
    //显示字体的行高
    CGFloat lineHeight=[@"Sample样本" sizeWithFont:font].height;
    NSInteger maxLine=floor(r.size.height/lineHeight);
    NSInteger totalLines=0;
 //   NSLog(@"Max Line Per Page: %d (%.2f/%.2f)",maxLine,r.size.height,lineHeight);
    NSString *lastParaLeft=nil;
    NSRange range=NSMakeRange(0, 0);
    
    //把字符串按段落分开, 提高解析效率
    NSArray *paragraphs=[self componentsSeparatedByString:@"\n"];
    for (int p=0;p< [paragraphs count];p++) {

        NSString *para;
        if (lastParaLeft!=nil) {
            //上一页完成后剩下的内容继续计算
            para=lastParaLeft;
            lastParaLeft=nil;
        }else {
            para=[paragraphs objectAtIndex:p];
            if (p<[paragraphs count]-1)
                para=[para stringByAppendingString:@"\n"]; //刚才分段去掉了一个换行,现在还给它
        }
        
        CGSize paraSize=[para sizeWithFont:font
                         constrainedToSize:r.size
                             lineBreakMode:NSLineBreakByCharWrapping];
        
        NSInteger paraLines=floor(paraSize.height/lineHeight);
        if (totalLines+paraLines<maxLine) {
            
            totalLines+=paraLines;
            range.length+=[para length];
            
            if (p==[paragraphs count]-1) {
                
                //到了文章的结尾 这一页也算
                [ranges addObject:[NSValue valueWithRange:range]];
                //IMILog(@”===========Page Over=============”);
            }
            
        }else if (totalLines+paraLines==maxLine) {
            
            //很幸运, 刚好一段结束,本页也结束, 有这个判断会提高一定的效率
            range.length+=[para length];
            [ranges addObject:[NSValue valueWithRange:range]];
            range.location+=range.length;
            range.length=0;
            totalLines=0;
            //IMILog(@”===========Page Over=============”);
            
        }else{
            
            //重头戏, 页结束时候本段文字还有剩余
            NSInteger lineLeft=maxLine-totalLines;
            CGSize tmpSize;
            NSInteger i;
            
            for (i=1; i<[para length]; i++) {
                
                //逐字判断是否达到了本页最大容量
                NSString *tmp=[para substringToIndex:i];
                tmpSize=[tmp sizeWithFont:font
                        constrainedToSize:r.size
                            lineBreakMode:NSLineBreakByCharWrapping];
                int nowLine=floor(tmpSize.height/lineHeight);
                
                if (lineLeft<nowLine) {
                    //超出容量,跳出, 字符要回退一个, 应为当前字符已经超出范围了
                    lastParaLeft=[para substringFromIndex:i-1];
                    break;
                }
            }
            
            range.length+=i-1;
            [ranges addObject:[NSValue valueWithRange:range]];
            range.location+=range.length;
            range.length=0;
            totalLines=0;
            p--;
            //IMILog(@”===========Page Over=============”);
        }
    }
    NSInteger length = [self length];//文字的长度
   // NSLog(@"length:%ld",length);
   // NSLog(@"change before:%@",[NSArray arrayWithArray:ranges]);

    BOOL isDone = NO;
    while (!isDone) {
        
        NSValue* lastRange = [ranges lastObject];//获取最后一个对象
        NSRange range = [lastRange rangeValue];//取得最后一个对象的区间值
        
        if (range.location >= length) {//如果最后一个的位置大于长度，直接移除
            [ranges removeLastObject];//移除最后一个数据
        }
        else{
            range.length = length - range.location;
            lastRange = [NSValue valueWithRange:range];
            [ranges replaceObjectAtIndex:[ranges count]-1 withObject:lastRange];
          //  NSLog(@"change after:%@",[NSArray arrayWithArray:ranges]);
            isDone = YES;
        }
    }
    return [NSArray arrayWithArray:ranges];
}

+(NSString*)getStringWithBaseUrl:(NSString *)para{
    
    NSString* baseUrl = @"http://www.23wx.com/";

    NSString* string = [NSString stringWithFormat:@"%@%@",baseUrl,para];
    
    NSLog(@"getStringWithBaseUrl string:%@",string);
    
    return string;
}

@end
