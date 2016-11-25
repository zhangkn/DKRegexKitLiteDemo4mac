//
//  main.m
//  DKRegexKitLiteDemo4mac
//
//  Created by devzkn on 25/11/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegexKitLite.h"

// 创业天使-xxx 120101_超清.mp4 --> 120101-创业天使-xxx.mp4
int main(int argc, const char * argv[])
{
    @autoreleasepool {
        NSFileManager *mgr = [NSFileManager defaultManager];
        NSString *dir = @"/Users/apple/Desktop/videos";
        NSArray *subpaths = [mgr subpathsAtPath:dir];
        for (NSString *subpath in subpaths) {
            if (![subpath hasSuffix:@"mp4"]) continue;
            // 获得全路径
            NSString *fullSubpath = [dir stringByAppendingPathComponent:subpath];
            // 获得文件名
            NSString *filename = [subpath.lastPathComponent stringByDeletingPathExtension];
            
            // 根据文件名获取对应的前缀和后缀
            NSString *prefix = [filename stringByMatching:@"(\\d{6})_.清" capture:YES];
            NSString *suffix = [filename stringByMatching:@"(.+) \\d{6}_.清" capture:YES];
            NSString *newFilename = [NSString stringWithFormat:@"%@-%@", prefix, suffix];
            
            // 生成新的全路径（替换）
            NSString *newFullSubpath = [fullSubpath stringByReplacingOccurrencesOfString:filename withString:newFilename];
            //            NSData *data = [NSData dataWithContentsOfFile:fullSubpath];
            //            [data writeToFile:newFullSubpath atomically:YES];
            //            [mgr removeItemAtPath:fullSubpath error:nil];
            
            // 剪切\移动
            [mgr moveItemAtPath:fullSubpath toPath:newFullSubpath error:nil];
        }
    }
    return 0;
}
