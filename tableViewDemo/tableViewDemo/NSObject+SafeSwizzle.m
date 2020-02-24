//
//  NSObject+SafeSwizzle.m
//
//
//  Created by LV on 2019/2/25.
//  Copyright © 2019. All rights reserved.
//

#import "NSObject+SafeSwizzle.h"

#import <objc/runtime.h>

@implementation NSObject (SafeSwizzle)

+ (void)safeExchangeInstanceMethod:(Class)aClass oldSel:(SEL)oldSEL newSel:(SEL)newSEL
{
    Method oldMethod = class_getInstanceMethod(aClass, oldSEL);
    Method newMethod = class_getInstanceMethod(aClass, newSEL);
    
    BOOL addNewMethod = class_addMethod(aClass,
                                        oldSEL,
                                        method_getImplementation(newMethod),
                                        method_getTypeEncoding(newMethod));
    if (addNewMethod) {
        class_replaceMethod(aClass,
                            newSEL,
                            method_getImplementation(oldMethod),
                            method_getTypeEncoding(oldMethod));
    } else {
        method_exchangeImplementations(oldMethod, newMethod);
    }
}

+ (BOOL)exitSel:(SEL)aSel inClass:(Class)aClass
{
    unsigned int count;
    Method *methodList = class_copyMethodList(aClass, &count);
    for (NSInteger i = 0; i < count; i ++) {
        Method method = methodList[i];
        NSString *tempMethodString = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
        if ([tempMethodString isEqualToString:NSStringFromSelector(aSel)]) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)class_addMethod:(Class)aClass selector:(SEL)aSel imp:(IMP)imp types:(const char *)type
{
    return class_addMethod(aClass, aSel, imp, type);
}

@end
