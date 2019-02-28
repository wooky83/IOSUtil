//
//  NSObject+OCB.h
//  OCB5
//
//  Created by 1002659 on 27/02/2019.
//  Copyright © 2019 skplanet. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SW)

- (void)setValue:(nullable id)value forKeyNil:(NSString *)key;
- (nullable id)valueForKeyNil:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
