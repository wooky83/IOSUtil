//
//  NSObject+OCB.m
//  OCB5
//
//  Created by 1002659 on 27/02/2019.
//  Copyright © 2019 skplanet. All rights reserved.
//

#import "NSObject+SW.h"

@implementation NSObject (SW)

- (void)setValue:(nullable id)value forKeyNil:(NSString *)key {
    @try {
        [self setValue:value forKey:key];
    } @catch (NSException *exception) {
        return;
    }
}

- (nullable id)valueForKeyNil:(NSString *)key {
    @try {
        return [self valueForKey:key];
    } @catch (NSException *exception) {
        return nil;
    }
}

@end
