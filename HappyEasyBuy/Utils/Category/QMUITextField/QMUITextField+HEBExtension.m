//
//  QMUITextField+HEBExtension.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/5.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUITextField+HEBExtension.h"

static BOOL hebTail = NO;
@interface QMUITextField ()

@end

@implementation QMUITextField (HEBExtension)
@dynamic tail;

- (instancetype)init
{
    self = [super init];
    if (self) {
        hebTail = NO;
    }
    return self;
}

- (void)setTail:(BOOL)tail {
    if (tail) {
        hebTail = tail;
        self.keyboardType = UIKeyboardTypeDecimalPad;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (hebTail) {
        if ([self.text componentsSeparatedByString:@"."].count > 2) {
            return NO;
        }
        NSString *text = self.text;
        NSString *decimalSeperator = @".";
        NSCharacterSet *charSet = nil;
        NSString *numberChars = @"0123456789";
        if ([string isEqualToString:decimalSeperator] && [text length] == 0) {
            return NO;
        }
        NSRange decimalRange = [text rangeOfString:decimalSeperator];
        BOOL isDecimalNumber = (decimalRange.location != NSNotFound);
        if (isDecimalNumber) {
            charSet = [NSCharacterSet characterSetWithCharactersInString:numberChars];
            if ([string rangeOfString:decimalSeperator].location != NSNotFound) {
                return NO;
            }
        }
        else {
            numberChars = [numberChars stringByAppendingString:decimalSeperator];
            charSet = [NSCharacterSet characterSetWithCharactersInString:numberChars];
        }
        NSCharacterSet *invertedCharSet = [charSet invertedSet];
        NSString *trimmedString = [string stringByTrimmingCharactersInSet:invertedCharSet];
        text = [text stringByReplacingCharactersInRange:range withString:trimmedString];
        if (isDecimalNumber) {
            NSArray *arr = [text componentsSeparatedByString:decimalSeperator];
            if ([arr count] == 2) {
                if ([arr[1] length] > 2) {
                    return NO;
                }
            }
        }
        textField.text = text;
        return NO;
    }
    return YES;
}

@end

