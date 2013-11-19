//
//  Utils.h
//  Monitoring
//
//  Created by Hossam on 11/11/13.
//  Copyright (c) 2013 Hossam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject


+(NSDate *)getDateFromString:(NSString *)dateString formate:(NSString *)format;

+(NSString *)getStringFromDate:(NSDate *)date format:(NSString *)format;

+(BOOL)callPhoneNumber:(NSString *)number;

+(void)showSystemAlert:(NSString *)title message:(NSString *)msg;
@end
