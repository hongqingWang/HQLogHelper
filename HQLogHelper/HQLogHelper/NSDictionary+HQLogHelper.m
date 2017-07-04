//
//  NSDictionary+HQLogHelper.m
//  HQLogHelper
//
//  Created by 王红庆 on 2016/12/15.
//  Copyright © 2016年 王红庆. All rights reserved.
//

#import "NSDictionary+HQLogHelper.h"

@implementation NSDictionary (HQLogHelper)

- (NSString *)descriptionWithLocale:(id)locale {
    
    NSString *string;
    
    @try {
        
        string = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
    } @catch (NSException *exception) {
        
        NSString *reason = [NSString stringWithFormat:@"reason:%@",exception.reason];
        string = [NSString stringWithFormat:@"转换失败:\n%@,\n转换终止,输出如下:\n%@",reason,self.description];
        
    } @finally {
        
    }
    
    return string;
}

@end
