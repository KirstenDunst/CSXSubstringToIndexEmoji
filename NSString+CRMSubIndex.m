//
//  NSString+CRMSubIndex.m
//  QuickPushCRM
//
//  Created by 曹世鑫 on 2019/5/30.
//  Copyright © 2019 CSX. All rights reserved.
//

#import "NSString+CRMSubIndex.h"
#import <objc/runtime.h>

@implementation NSString (CRMSubIndex)

+ (void)load {
    Method substringToIndex = class_getInstanceMethod(self, @selector(substringToIndex:));

    Method substringToIndexNew = class_getInstanceMethod(self, @selector(substringToIndexNew:));

    method_exchangeImplementations(substringToIndex, substringToIndexNew);
}

- (NSString *)substringToIndexNew:(NSInteger)index {
    if (self.length <= index) {
        return self;
    }
    NSRange rangeIndex = [self rangeOfComposedCharacterSequenceAtIndex:index];
    if (rangeIndex.length == 1) {
        NSRange rangeRange = [self rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, index)];
        return [self substringWithRange:rangeRange];
    } else {
        NSRange rangeRange = [self rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, index-1)];
        return [self substringWithRange:rangeRange];
    }
}

@end
