//
//  Utils.m
//  Monitoring
//
//  Created by Hossam on 11/11/13.
//  Copyright (c) 2013 Hossam. All rights reserved.
//

#import "Utils.h"

@implementation Utils

//yyyy-MM-dd\'T\'HH:mm:ssZZZZZ"
+(NSDate *)getDateFromString:(NSString *)dateString formate:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSDate *date = [formatter dateFromString:dateString];

    return date;
}

+(NSString *)getStringFromDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+(BOOL)callPhoneNumber:(NSString *)number
{
    number = [number stringByReplacingOccurrencesOfString:@"-" withString:@""];
    number = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber *num = [numberFormatter numberFromString:number];
    
    NSLog(@">>>%@", num);
    if (nil == num) {
        [Utils showSystemAlert:@"Alert" message:@"Invalid phone number!"];
        return NO;
    }
    
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:number];
    BOOL isSupported = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
    if (!isSupported) {
        [Utils showSystemAlert:@"Alert" message:@"Your device doesn't support calling feature"];
    }
    
    return isSupported;
}

+(void)showSystemAlert:(NSString *)title message:(NSString *)msg
{
    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [Notpermitted show];
}
@end
