//
//  NSDate+CNKIZ.h
//


#import "NSDate+CNKIZ.h"

@implementation NSDate (CNKIZ)

- (NSString *)convertDateToStringWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
//    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
//    [dateFormatter setTimeZone:timeZone];
    NSString *dateStr = [dateFormatter stringFromDate:self];
#if !__has_feature(objc_arc)
    [dateFormatter release];
#endif
    
    return dateStr;
}

- (NSDate *)convertStringToDate:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:format];
//    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
//    [dateFormatter setTimeZone:timeZone];
    NSDate *date = [dateFormatter dateFromString:string];
#if !__has_feature(objc_arc)
    [dateFormatter release];
#endif
    return date;
}

- (NSDate *)dateByMovingToBeginningOfDay
{
    
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSDate *)dateByMovingToEndOfDay
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [parts setHour:23];
    [parts setMinute:59];
    [parts setSecond:59];
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSDate *)dateByMovingToFirstDayOfTheMonth
{
    NSDate *d = nil;
    //BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&d interval:NULL forDate:self];
    //NSAssert1(ok, @"Failed to calculate the first day the month based on %@", self);
    
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&d interval:NULL forDate:self];
    return d;
}

- (NSDate *)dateByMovingToFirstDayOfThePreviousMonth
{
    //NSDateComponents *c = [[[NSDateComponents alloc] init] autorelease];
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.month = -1;
    return [[[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0] dateByMovingToFirstDayOfTheMonth];
}

- (NSDate *)dateByMovingToFirstDayOfTheFollowingMonth
{
    //NSDateComponents *c = [[[NSDateComponents alloc] init] autorelease];
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.month = 1;
    return [[[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0] dateByMovingToFirstDayOfTheMonth];
}

- (NSDateComponents *)componentsForMonthDayAndYear
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
}
- (NSDateComponents *)componentsForAll
{
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    return [[NSCalendar currentCalendar] components:unitFlags fromDate:self];
    
    /*
     comps = [calendar components:unitFlags fromDate:self];
     
     int week = [comps weekday];
     int year=[comps year];
     int month = [comps month];
     int day = [comps day];
     //[formatter setDateStyle:NSDateFormatterMediumStyle];
     //This sets the label with the updated time.
     int hour = [comps hour];
     int min = [comps minute];
     int sec = [comps second];
     
     */
}
- (NSUInteger)weekday
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfYear forDate:self];
}

- (NSUInteger)numberOfDaysInMonth
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}


@end
