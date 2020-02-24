//
//  KKADScrollViewDelegateDispatcher.m
//  tableViewDemo
//
//  Created by scl on 2020/2/20.
//  Copyright © 2020 scl. All rights reserved.
//

#import "KKScrollViewEventInterceptor.h"

@interface KKScrollViewEventInterceptor ()

@property (nonatomic, strong) NSPointerArray *pointerArray;

@end

@implementation KKScrollViewEventInterceptor

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    SEL selector = @selector(scrollViewDidScroll:);
    if ([self.delegate respondsToSelector:selector]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
    
    for (id listener in self.pointerArray) {
        if ([listener respondsToSelector:selector]) {
            [listener scrollViewDidScroll:scrollView];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    SEL selector = @selector(scrollViewDidEndDecelerating:);
    if (self.delegate && [self.delegate respondsToSelector:selector]) {
        [self.delegate scrollViewDidEndDecelerating:scrollView];
    }
    
    for (id listener in self.pointerArray) {
        if ([listener respondsToSelector:selector]) {
            [listener scrollViewDidEndDecelerating:scrollView];
        }
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    SEL selector = @selector(tableView:willDisplayCell:forRowAtIndexPath:);
       if (self.delegate && [self.delegate respondsToSelector:selector]) {
           [self.delegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
       }
       
       for (id listener in self.pointerArray) {
           if ([listener respondsToSelector:selector]) {
               [listener tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
           }
       }
}

#pragma mark - Public method

- (void)addScrollListener:(id)listener
{
    [self.pointerArray addPointer:(__bridge void * _Nullable)(listener)];
    if (self.pointerArray.count > 10) {
        [self.pointerArray compact];
    }
}

- (void)removeScrollListener:(id)listener
{
    int index = -1;
    for (int i = 0; i < self.pointerArray.count; i++) {
        id element = [self.pointerArray pointerAtIndex:i];
        if (element == listener) {
            index = i;
        }
    }
    
    if (index >= 0 && index < self.pointerArray.count) {
        [self.pointerArray removePointerAtIndex:index];
    }
}

#pragma mark - Runtime

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ( [self.delegate respondsToSelector:aSelector]) {
        return self.delegate;
    }
 
    return [super forwardingTargetForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [anInvocation invokeWithTarget:self.delegate];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([self.delegate respondsToSelector:aSelector]) {
        return YES;
    }
    
    return [super respondsToSelector:aSelector];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    if ([self conformsToProtocol:aProtocol]) {
        return YES;
    }
    
    return [self.delegate conformsToProtocol:aProtocol];
}

+ (BOOL)conformsToProtocol:(Protocol *)protocol
{
    return YES;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    NSMethodSignature *methodSignture = [super methodSignatureForSelector:sel];
    if (methodSignture) {
        return methodSignture;
    }
    
    return [self.delegate methodSignatureForSelector:sel];
}

#pragma mark - Getter

- (NSPointerArray *)pointerArray
{
    if (!_pointerArray) {
        _pointerArray = [NSPointerArray weakObjectsPointerArray];
    }
    
    return _pointerArray;
}

@end
