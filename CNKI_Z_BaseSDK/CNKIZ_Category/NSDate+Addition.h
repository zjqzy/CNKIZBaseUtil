//
//  NSDate+Addition.h
//
//  Created by zhujianqi  2013年
//  Copyright (c) 2013年以后 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)

/**
 *  将日期转化为字符串。
 *  @param  format:转化格式，形如@"yyyy年MM月dd日hh时mm分ss秒"。
 *  return  返回转化后的字符串。
 */
- (NSString *)convertDateToStringWithFormat:(NSString *)format;

/**
 *  将字符串转化为日期。
 *  @param  string:给定的字符串日期。
 *  @param  format:转化格式，形如@"yyyy年MM月dd日hh时mm分ss秒"。日期格式要和string格式一致，否则会为空。
 *  return  返回转化后的日期。
 */
- (NSDate *)convertStringToDate:(NSString *)string format:(NSString *)format;

/**
 *
 */
- (NSDate *)dateByMovingToBeginningOfDay;
- (NSDate *)dateByMovingToEndOfDay;
- (NSDate *)dateByMovingToFirstDayOfTheMonth;
- (NSDate *)dateByMovingToFirstDayOfThePreviousMonth;
- (NSDate *)dateByMovingToFirstDayOfTheFollowingMonth;

/**
 * 
 * 
 */
- (NSDateComponents *)componentsForMonthDayAndYear;
- (NSDateComponents *)componentsForAll;

/**
 * 得到星期几
 * return [0,6]
 */
- (NSUInteger)weekday;

/**
 * 得到 月 的第几天
 * 
 */
- (NSUInteger)numberOfDaysInMonth;

@end
