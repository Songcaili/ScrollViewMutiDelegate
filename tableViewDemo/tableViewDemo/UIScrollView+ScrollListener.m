//
//  UIScrollView+Ad.m
//  tableViewDemo
//
//  Created by scl on 2020/2/7.
//  Copyright © 2020 scl. All rights reserved.
//

#import "UIScrollView+ScrollListener.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "NSObject+SafeSwizzle.h"
#import "KKScrollViewEventInterceptor.h"

@interface UIScrollView ()

@property (nonatomic, strong) KKScrollViewEventInterceptor *interceptor;

@end

@implementation UIScrollView (ScrollListener) 

+ (void)load {
    [self safeExchangeInstanceMethod:[self class] oldSel:@selector(setDelegate:) newSel:@selector(swizzle_setDelegate:)];
    [self safeExchangeInstanceMethod:[self class] oldSel:@selector(delegate) newSel:@selector(swizzle_delegate)];
}

- (void)swizzle_setDelegate:(id<UIScrollViewDelegate>)delegate
{
    objc_setAssociatedObject(self, @selector(delegate), delegate, OBJC_ASSOCIATION_ASSIGN);
    [self swizzle_setDelegate:self.interceptor];
    [self setRealScrollDelegate];
}

- (id<UIScrollViewDelegate>)swizzle_delegate
{
    return objc_getAssociatedObject(self, @selector(delegate));
}

- (KKScrollViewEventInterceptor *)interceptor
{
    return objc_getAssociatedObject(self, @selector(interceptor));
}

- (void)setInterceptor:(KKScrollViewEventInterceptor *)dispatcher
{
    objc_setAssociatedObject(self, @selector(interceptor), dispatcher, OBJC_ASSOCIATION_RETAIN);
}

- (void)setRealScrollDelegate
{
    if ([self swizzle_delegate] != nil) {
        return;
    }
    
    self.interceptor = [[KKScrollViewEventInterceptor alloc] init];
    self.interceptor.delegate = self.delegate;
    [self swizzle_setDelegate:self.interceptor];
}

- (void)addScrollListener:(id)listener
{
    [self.interceptor addScrollListener:listener];
}

- (void)removeScrollListener:(id)listener
{
    [self.interceptor removeScrollListener:listener];
}

@end
