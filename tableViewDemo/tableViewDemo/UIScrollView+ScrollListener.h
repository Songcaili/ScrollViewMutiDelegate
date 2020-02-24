//
//  UIScrollView+Ad.h
//  tableViewDemo
//
//  Created by scl on 2020/2/7.
//  Copyright © 2020 scl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (ScrollListener) <UIScrollViewDelegate>

- (void)addScrollListener:(id)listener;

- (void)removeScrollListener:(id)listener;

@end

NS_ASSUME_NONNULL_END
