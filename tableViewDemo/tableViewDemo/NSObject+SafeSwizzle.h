//
//  NSObject+SafeSwizzle.h
//  
//
//  Created by LV on 2019/2/25.
//  Copyright © 2019. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SafeSwizzle)

+ (void)safeExchangeInstanceMethod:(Class)aClass oldSel:(SEL)oldSEL newSel:(SEL)newSEL;

+ (BOOL)exitSel:(SEL)aSel inClass:(Class)aClass;

+ (BOOL)class_addMethod:(Class)aClass selector:(SEL)aSel imp:(IMP)imp types:(const char *)type;

@end
