//
//  NSString+CBExtension.m
//  ClipboardTool_iOS
//
//  Created by dawng on 2017/8/29.
//  Copyright © 2017年 dwang. All rights reserved.
//

#import "NSString+HEBExtension.h"

@implementation NSString (HEBExtension)
@dynamic getUserDefaultsINFO;
@dynamic removeUserDefaultsINFO;
@dynamic timeStampYYYYMMDDPoint;
@dynamic timeStampYYYYMMDDHHMMSS;
@dynamic heightWith12_30;
@dynamic heightWith14_30;
@dynamic heightWith14_90;
@dynamic removeMoneySymbol;
@dynamic encryptMobNumber;
@dynamic removeSpace;
@dynamic removeline;

- (NSString *)removeSpace {
    return [[self stringByReplacingOccurrencesOfString:@" " withString:@""] copy];
}

- (NSString *)removeline {
    return [[self stringByReplacingOccurrencesOfString:@"-" withString:@""] copy];
}

- (NSString *)removeMoneySymbol {
    return [[self stringByReplacingOccurrencesOfString:@"¥" withString:@""] copy];
}

- (id)getUserDefaultsINFO {
   return [[NSUserDefaults standardUserDefaults] objectForKey:self];
}

- (void)setRemoveUserDefaultsINFO:(BOOL)removeUserDefaultsINFO {
    if (removeUserDefaultsINFO) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:self];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSString *)timeStampYYYYMMDDPoint {
    return [[self timeStamp:@"yyyy.MM.dd"] copy];
}

- (NSString *)timeStampYYYYMMDDHHMMSS {
    return [[self timeStamp:@"yyyy-MM-dd hh:mm:ss"] copy];
}

- (NSString *)timeStamp:(NSString *)type {
    NSTimeInterval time = [self doubleValue];
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:type];
    return [[dateFormatter stringFromDate:detaildate] copy];
}

- (CGFloat)heightWith12_30 {
    return [self stringHeightWithFontSize:12 andWidth:30];
}

- (CGFloat)heightWith14_30 {
    return [self stringHeightWithFontSize:14 andWidth:30];
}

- (CGFloat)heightWith14_90 {
    return [self stringHeightWithFontSize:14 andWidth:90];
}

- (CGFloat)stringHeightWithFontSize:(float)size andWidth:(float)width {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
    CGRect rect = [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - width, 0) options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}

- (CGFloat)stringWidthWithFontSize:(float)size {
    CGSize textSize = [self sizeWithAttributes:@{NSFontAttributeName:UIFontMake(size)}];
    return textSize.width;
}

- (NSString *)encryptMobNumber {
    if (self.isMobNumber) {
        return [[self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"] copy];
    }
    return self;
}

- (void)setCallPhone:(BOOL)callPhone {
    if (callPhone) {
        if (self.isMobNumber) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", self]]];
        }
    }
}

@end
